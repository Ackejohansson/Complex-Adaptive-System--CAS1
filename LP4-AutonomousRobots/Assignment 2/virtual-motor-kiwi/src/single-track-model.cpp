/*
 * 
 right (C) 2018 Ola Benderius
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

#include <cmath>
#include <iostream>
#include "single-track-model.hpp"

SingleTrackModel::SingleTrackModel() noexcept:
  m_wLMutex{},
  m_wRMutex{},
  m_longitudinalSpeed{0.0},
  m_lateralSpeed{0.0},
  m_yawRate{0.0},
  m_wL{0.0},
  m_wR{0.0}
{
}

void SingleTrackModel::setLeftAxleAngularVelocity(opendlv::proxy::AxleAngularVelocityRequest const &wL) noexcept
{
  std::lock_guard<std::mutex> lock(m_wLMutex);
  m_wL = wL.axleAngularVelocity();
}
void SingleTrackModel::setRightAxleAngularVelocity(opendlv::proxy::AxleAngularVelocityRequest const &wR) noexcept
{
  std::lock_guard<std::mutex> lock(m_wRMutex);
  m_wR = wR.axleAngularVelocity();
}


opendlv::sim::KinematicState SingleTrackModel::step() noexcept
{
  float const car_radius{0.12f};
  float const wheel_radius{0.04f};
  float wLCopy;
  float wRCopy;
  float vL; 
  float vR;
  {
    std::lock_guard<std::mutex> lock1(m_wLMutex);
    std::lock_guard<std::mutex> lock2(m_wRMutex);
    wLCopy = m_wL;
    wRCopy = m_wR;
  }
  vL = wLCopy*wheel_radius;
  vR = wRCopy*wheel_radius;
  
  m_lateralSpeed = (vL+vR)/2;
  m_yawRate = (vR-vL)/(2*car_radius);
  
  opendlv::sim::KinematicState kinematicState;
  kinematicState.vx(static_cast<float>(m_lateralSpeed));
  kinematicState.vy(static_cast<float>(0.0f));
  kinematicState.yawRate(static_cast<float>(m_yawRate));

  return kinematicState;
}
