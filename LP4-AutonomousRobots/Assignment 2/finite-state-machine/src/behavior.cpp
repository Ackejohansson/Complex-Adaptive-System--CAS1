/*
 * Copyright (C) 2018 Ola Benderius
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "behavior.hpp"
#include <iostream>
#include <algorithm>
#include <cmath>

Behavior::Behavior() noexcept:
  m_frontUsReading{},
  m_rearUsReading{},
  m_leftIrReading{},
  m_rightIrReading{},
  m_leftAxleAngularVelocityRequest{},
  m_rightAxleAngularVelocityRequest{},
  m_frontUsReadingMutex{},
  m_rearUsReadingMutex{},
  m_leftIrReadingMutex{},
  m_rightIrReadingMutex{},
  m_leftAxleAngularVelocityRequestMutex{},
  m_rightAxleAngularVelocityRequestMutex{}
{
}

opendlv::proxy::AxleAngularVelocityRequest Behavior::getLeftAxleAnglularVelocityRequest() noexcept
{
  std::lock_guard<std::mutex> lock(m_leftAxleAngularVelocityRequestMutex);
  return m_leftAxleAngularVelocityRequest;
}

opendlv::proxy::AxleAngularVelocityRequest Behavior::getRightAxleAnglularVelocityRequest() noexcept
{
  std::lock_guard<std::mutex> lock(m_rightAxleAngularVelocityRequestMutex);
  return m_rightAxleAngularVelocityRequest;
}



void Behavior::setFrontUs(opendlv::proxy::DistanceReading const &frontUsReading) noexcept
{
  std::lock_guard<std::mutex> lock(m_frontUsReadingMutex);
  m_frontUsReading = frontUsReading;
}

void Behavior::setRearUs(opendlv::proxy::DistanceReading const &rearUsReading) noexcept
{
  std::lock_guard<std::mutex> lock(m_rearUsReadingMutex);
  m_rearUsReading = rearUsReading;
}

void Behavior::setLeftIr(opendlv::proxy::DistanceReading const &leftIrReading) noexcept
{
  std::lock_guard<std::mutex> lock(m_leftIrReadingMutex);
  m_leftIrReading = leftIrReading;
}

void Behavior::setRightIr(opendlv::proxy::DistanceReading const &rightIrReading) noexcept
{
  std::lock_guard<std::mutex> lock(m_rightIrReadingMutex);
  m_rightIrReading = rightIrReading;
}


void Behavior::step(float time, bool VERBOSE) noexcept
{
  opendlv::proxy::DistanceReading frontUsReading;
  opendlv::proxy::DistanceReading rearUsReading;
  opendlv::proxy::DistanceReading leftIrReading;
  opendlv::proxy::DistanceReading rightIrReading;
  {
    std::lock_guard<std::mutex> lock1(m_frontUsReadingMutex);
    std::lock_guard<std::mutex> lock2(m_rearUsReadingMutex);
    std::lock_guard<std::mutex> lock3(m_leftIrReadingMutex);
    std::lock_guard<std::mutex> lock4(m_rightIrReadingMutex);

    frontUsReading = m_frontUsReading;
    rearUsReading = m_rearUsReading;
    leftIrReading = m_leftIrReading;
    rightIrReading = m_rightIrReading;
  }

  float frontDistance = frontUsReading.distance();
  float rearDistance = rearUsReading.distance();
  float leftDistance = leftIrReading.distance()*6;
  float rightDistance = rightIrReading.distance()*6;
  

  if (VERBOSE){
    std::cout << "Front distance: " << frontDistance
    << "\nRear distance: " << rearDistance
    << "\nLeft distance: " << leftDistance
    << "\nRight distance: " << rightDistance
    << "\nTime: " << time << std::endl;
  }

  const float speed = 0.3f;
  const float turnSpeed = 0.38f;
  const float wheel_radius = 0.04f;
  const float car_radius = 0.12f;

  float vL = speed;
  float vR = speed;
  float minSafeDist = 0.08f;
  float minDistTol = (static_cast<float>(sqrt(2))-1)*car_radius + static_cast<float>(sqrt(2))*minSafeDist;
  float minDist = std::min({frontDistance, leftDistance, rightDistance});
  
  if (minDist < minDistTol) {
    if (leftDistance < rightDistance) {
      vL = turnSpeed;
      vR = -turnSpeed;
    } else {
      vL = -turnSpeed;
      vR = turnSpeed;
    }
  } 
  
  float wL = vL/wheel_radius;
  float wR = vR/wheel_radius;
  
  // Returns the requests
  std::lock_guard<std::mutex> lock1(m_leftAxleAngularVelocityRequestMutex);
  opendlv::proxy::AxleAngularVelocityRequest leftAxleAngularVelocityRequest;
  leftAxleAngularVelocityRequest.axleAngularVelocity(wL);
  m_leftAxleAngularVelocityRequest = leftAxleAngularVelocityRequest;
  
  std::lock_guard<std::mutex> lock2(m_rightAxleAngularVelocityRequestMutex);
  opendlv::proxy::AxleAngularVelocityRequest rightAxleAngularVelocityRequest;
  rightAxleAngularVelocityRequest.axleAngularVelocity(wR);
  m_rightAxleAngularVelocityRequest = rightAxleAngularVelocityRequest;
}


