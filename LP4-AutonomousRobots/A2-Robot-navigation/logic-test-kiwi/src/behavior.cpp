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

Behavior::Behavior() noexcept:
  m_leftAxleAngularVelocityRequest{},
  m_rightAxleAngularVelocityRequest{},
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


void Behavior::step(float time) noexcept
{
  const float t1 = 3;
  const float t2 = 10;
  const float v0 = 0.5;
  float wheel_radius = 0.04f;
  float vL;
  float vR;
  float wL;
  float wR;
  if (0 <= time && time <= t1){
    vL = 0.0;
    vR = v0*time/t1;
  }
  else if (time <= t2){
    vL = v0*(time-t1)/t2;
    vR = v0;
  }
  else {
    vL = 0.0;
    vR = 0.0;
  }
  wL = vL/wheel_radius;
  wR = vR/wheel_radius;
  
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
