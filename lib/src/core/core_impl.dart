// Copyright (c) 2014-2015, Nicolas François
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of graystone;

abstract class Connection {

  Future open();

  Future close();

}

abstract class Device {

  final Connection connection;

  Device(this.connection);

  Future init();

}

typedef void RobotBehaviour();

class Robot {

  final List<Device> devices;
  final List<Connection> connections;
  RobotBehaviour behaviour;

  Robot(this.connections, this.devices);

  void start(){
   Future.wait(connections.map((conn) => conn.open()), eagerError: true)
         .then((_) => Future.wait(devices.map((device) => device.init())))
         .then((_) => behaviour());
  }

  void stop(){
    connections.forEach((connection) => connection.close());
  }

}
