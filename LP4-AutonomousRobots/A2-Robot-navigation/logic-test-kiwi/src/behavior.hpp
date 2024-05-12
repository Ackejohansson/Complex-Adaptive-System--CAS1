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

#ifndef BEHAVIOR
#define BEHAVIOR
#include <mutex>
#include "opendlv-standard-message-set.hpp"

class Behavior {
 private:
  Behavior(Behavior const &) = delete;
  Behavior(Behavior &&) = delete;
  Behavior &operator=(Behavior const &) = delete;
  Behavior &operator=(Behavior &&) = delete;

 public:
  Behavior() noexcept;
  ~Behavior() = default;

 public:
  opendlv::proxy::AxleAngularVelocityRequest getLeftAxleAnglularVelocityRequest() noexcept;
  opendlv::proxy::AxleAngularVelocityRequest getRightAxleAnglularVelocityRequest() noexcept;
  void step(float time) noexcept;

 private:
  opendlv::proxy::AxleAngularVelocityRequest m_leftAxleAngularVelocityRequest;
  opendlv::proxy::AxleAngularVelocityRequest m_rightAxleAngularVelocityRequest;
  std::mutex m_leftAxleAngularVelocityRequestMutex;
  std::mutex m_rightAxleAngularVelocityRequestMutex;
};

#endif
