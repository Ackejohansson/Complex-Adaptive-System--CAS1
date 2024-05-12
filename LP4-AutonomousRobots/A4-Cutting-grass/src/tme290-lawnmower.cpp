#include <iostream>
#include "cluon-complete.hpp"
#include "tme290-sim-grass-msg.hpp"
#include <random>
#include <ctime>
#include <algorithm>
#include <vector>
#include <queue>
#include <cmath>
#include <limits>

// Variables and constants
const float rainThreshold = 0.8f;
const float batteryThreshold = 0.29f;
const int gridSize = 40;
const uint32_t chargePosition[2] = {0, gridSize-1};
const uint32_t wallLocation{22};
bool movingToTarget{true};

std::vector<std::pair<int, int>> path;
std::vector<std::pair<int, int>> differences;
std::vector<int> controlCommand = {7, 8, 1, 6, 0, 2, 5, 4, 3};
std::random_device rd;
std::mt19937 gen(rd());
std::uniform_int_distribution<int> dist(0, gridSize-10);
std::vector<std::vector<int>> grid(gridSize, std::vector<int>(gridSize, 0));


enum class Behavior {
  GoToChargingStation,
  Charging,
  GoToTarget,
  AvoidRain,
  CutGrass,
};

std::string behaviorToString(Behavior behavior) {
  switch (behavior) {
    case Behavior::GoToChargingStation:
      return "GoToChargingStation";
    case Behavior::Charging:
      return "Charging";  
    case Behavior::GoToTarget:
      return "GoToTarget";
    case Behavior::AvoidRain:
      return "AvoidRain";
    case Behavior::CutGrass:
      return "CutGrass";
    default:
      return "GoToChargingStation";
  }
}


// A STAR
struct Node {
  int x, y;
  int g;
  int h;
  int f;
  Node* parent;

  Node(int xPos, int yPos, int hVal, int gVal, Node* parentNode)
    : x(xPos), y(yPos), g(gVal), h(hVal), f(gVal + hVal), parent(parentNode){}
};

struct CompareNode{
  bool operator()(const Node* a, const Node* b) const{
    return a->f > b->f;
  }
};

bool isUnblocked(int x, int y){
  return (grid[x][y] != -1);
}

bool isValid(int x, int y){
  return (x >= 0 && x < gridSize && y >= 0 && y < gridSize);
}

int calculateHeuristic(int x, int y, int goalX, int goalY){
  return static_cast<int>(std::pow(x - goalX, 2) + std::pow(y - goalY, 2));
}

std::vector<std::pair<int, int>> astar(int startX, int startY, int goalX, int goalY) {
  std::vector<std::pair<int, int>> directions = {{-1, 1}, {0, 1}, {1, 1}, {1, 0}, {1, -1}, {0, -1}, {-1, -1}, {-1, 0}};
  std::vector<std::vector<bool>> visited(gridSize, std::vector<bool>(gridSize, false));
  std::vector<std::vector<Node*>> nodes(gridSize, std::vector<Node*>(gridSize, nullptr));
  std::priority_queue<Node*, std::vector<Node*>, CompareNode> openSet;
  
  Node* startNode = new Node(startX, startY, 0, 0, nullptr);
  nodes[startX][startY] = startNode;
  openSet.push(startNode);
  
  while (!openSet.empty()) {
    Node* currentNode = openSet.top();
    openSet.pop();
    int x = currentNode->x;
    int y = currentNode->y;
    visited[x][y] = true;

    if (x == goalX && y == goalY){
      while (currentNode != nullptr){
        path.push_back({currentNode->x, currentNode->y});
        currentNode = currentNode->parent;
      }
      std::reverse(path.begin(), path.end());
      return path;
    }
    
    // Explore neighbours
    for(const auto& dir : directions){
      int newX = x + dir.first;
      int newY = y + dir.second;

      if (isValid(newX, newY) && isUnblocked(newX, newY) && !visited[newX][newY]){
        int newG = currentNode->g + 1;
        int newH = calculateHeuristic(newX, newY, goalX, goalY);
        int newF = newG + newH;

        if (nodes[newX][newY] == nullptr || newF < nodes[newX][newY]->f){
          Node* newNode = new Node(newX, newY, newG, newH, currentNode);
          nodes[newX][newY] = newNode;
          openSet.push(newNode);
        }
      }
    }
  }
  return {};
                                       }


// FUNCTIONS
void generateRandomTarget(){
  int randY{dist(gen)};
  while (randY == wallLocation) {
    randY = dist(gen);
  }
  path.clear();
  astar(chargePosition[0], chargePosition[1], dist(gen), randY);
  differences.clear();
  for (size_t i=0; i < path.size()-1; i++){
    differences.push_back(std::make_pair(path[i+1].first-path[i].first, path[i+1].second-path[i].second));
  }
}

void goToTarget(tme290::grass::Control& control) {  
  int dx = differences[0].first;
  int dy = differences[0].second;
  int i = 3*(dx+1) + dy + 1;
  int moveCommand = controlCommand[i];
  control.command(moveCommand);
  if (!differences.empty()) {
    differences.erase(differences.begin());
    return;
  }
  path.clear();
  movingToTarget = false;
}

void charge(tme290::grass::Control& control) {
  control.command(0);
}

void avoidRain(tme290::grass::Control& control) {
  control.command(4);
}

void cutGrass(tme290::grass::Control& control, int currentTime, const tme290::grass::Sensors& msg) {
  if (currentTime % 2){
    control.command(0);
    return;
  }
  std::vector<float> grassStatus = {msg.grassTopLeft(), msg.grassTopCentre(), msg.grassTopRight(), msg.grassRight(), msg.grassBottomRight(), msg.grassBottomCentre(), msg.grassBottomLeft(), msg.grassLeft()};
  auto maxElement = std::max_element(grassStatus.begin(), grassStatus.end());
  int maxIndex = std::distance(grassStatus.begin(), maxElement) + 1;
  control.command(maxIndex);
}




// The brain where all logic is executed
void updateBehavior(const tme290::grass::Sensors& msg, Behavior& currentBehavior, int32_t time) {
  // Charge
  if (msg.i() == chargePosition[0] && msg.j() == 39-chargePosition[1]){
    if (msg.battery() < 1){
      currentBehavior = Behavior::Charging;
      return;
    } 
    movingToTarget = true;
  }
  
  // Go to charge station
  if (msg.battery() <= batteryThreshold) {
    if (currentBehavior == Behavior::GoToChargingStation){
      return;
    }
    path.clear();
    if (msg.battery() <= static_cast<float>(astar(msg.i(), 39-msg.j(), chargePosition[0], chargePosition[1]).size()*0.004 + 0.008)){
      differences.clear();
      for (size_t i=0; i < path.size()-1; i++){
        differences.push_back(std::make_pair(path[i+1].first-path[i].first, path[i+1].second-path[i].second));
      }
      currentBehavior = Behavior::GoToChargingStation;
      return;
    }
  }
  
  // Go to target
  if (movingToTarget){
    if (currentBehavior != Behavior::GoToTarget && time % 2 == 0){
      generateRandomTarget();
    }
    currentBehavior = Behavior::GoToTarget;
    return;
  }
  
  // Avoid rain
  if (msg.rain() > rainThreshold) {
    currentBehavior = Behavior::AvoidRain;
    return;
  }

  // Cut grass
  currentBehavior = Behavior::CutGrass;
}


int32_t main(int32_t argc, char **argv) {
  int32_t retCode{1};
  auto commandlineArguments = cluon::getCommandlineArguments(argc, argv);
  if (0 == commandlineArguments.count("cid")) {
    std::cerr << argv[0] 
      << " is a lawn mower control algorithm." << std::endl;
    std::cerr << "Usage:   " << argv[0] << " --cid=<OpenDLV session>" 
      << "[--verbose]" << std::endl;
    std::cerr << "Example: " << argv[0] << " --cid=111 --verbose" << std::endl;
    return retCode;
  } 
  bool const verbose{commandlineArguments.count("verbose") != 0};
  uint16_t const cid = std::stoi(commandlineArguments["cid"]);
  cluon::OD4Session od4{cid};
  
  int32_t time{0};
  Behavior currentBehavior = Behavior::CutGrass;
  tme290::grass::Control control;
  for (int col = 0; col <= 21; ++col) {
    grid[col][wallLocation] = -1;
  }

  auto onSensors{[&od4, &time, &currentBehavior, &control](cluon::data::Envelope &&envelope){
    auto msg = cluon::extractMessage<tme290::grass::Sensors>(std::move(envelope));
    updateBehavior(msg, currentBehavior, time);

    switch (currentBehavior) {
      case Behavior::GoToChargingStation:
        goToTarget(control);
        break;
      case Behavior::Charging:
        charge(control);
        break;
      case Behavior::GoToTarget:
        goToTarget(control);
        break;
      case Behavior::AvoidRain:
        avoidRain(control);
        break;
      case Behavior::CutGrass:
        cutGrass(control, time, msg);
        break;
    }

    od4.send(control);
    time++;
  }};


  std::ofstream outputFile("/home/axeljohansson/opendlv-tutorials/opendlv-desktop-data/assignment4/data/grassStatus.csv");
  auto onStatus{[&verbose, &outputFile](cluon::data::Envelope &&envelope)
    {
      auto msg = cluon::extractMessage<tme290::grass::Status>(std::move(envelope));
      if (msg.time() < 20*60*24){
        outputFile << msg.time() << "," << msg.grassMean() << "," << msg.grassMax() << std::endl;
      } else {
        outputFile.close();
      }
      if (verbose) {
        std::cout << "Status at time " << msg.time() << ": " 
          << msg.grassMean() << "/" << msg.grassMax() << std::endl;
      }
    }};
  
  od4.dataTrigger(tme290::grass::Sensors::ID(), onSensors);
  od4.dataTrigger(tme290::grass::Status::ID(), onStatus);
  
  control.command(5);
  od4.send(control);

  while (od4.isRunning()) {
    std::this_thread::sleep_for(std::chrono::milliseconds(1000));
  }
  retCode = 0;
  return retCode;
}