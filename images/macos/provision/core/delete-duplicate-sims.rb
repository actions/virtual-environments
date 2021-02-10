#!/usr/bin/env ruby

# What is this for?
# This script fixes an issue appeared for some Xcode users where it would show long identifiers
# in the list of simulators instead of usual short names. This is caused by duplicate simulators
# being sometimes created after switching between Xcode versions, with the same
# device type + runtime pair occurring more than once in your list of available simulators.
# Instead of showing the same simulator name twice, Xcode defaults to simulator identifiers.
#
# What it does?
# The script queries Xcode's `simctl` utility for all simulators you have, finds duplicate type + runtime pairs,
# and offers you to delete them. After that, Xcode should return to displaying the list of simulators normally.
# When searching for duplicates, the script sorts simulators by their creation time to make sure it deletes
# the copy that was created more recently.
#
# License
# This script was taken from https://gist.github.com/vlas-voloshin/f9982128200345cd3fb7 and some modifications made
# Distributed by MIT license, license can be found at the bottom of this script

class SimDevice
  
    attr_accessor :runtime
    attr_accessor :name
    attr_accessor :identifier
    attr_accessor :timestamp
    
    def initialize(runtime, name, identifier, timestamp)
      @runtime = runtime
      @name = name
      @identifier = identifier
      @timestamp = timestamp
    end
    
    def to_s
      return "#{@name} - #{@runtime} (#{@identifier}) [#{@timestamp}]"
    end
    
    def equivalent_to_device(device)
      return @runtime == device.runtime && @name == device.name
    end
    
  end
  
  # Executes a shell command and returns the result from stdout
  def execute_simctl_command(command)
    return %x[xcrun simctl #{command}]
  end
  
  # Retrieves the creation date/time of simulator with specified identifier
  def simulator_creation_date(identifier)
    directory = Dir.home() + "/Library/Developer/CoreSimulator/Devices/" + identifier
    if (Dir.exists?(directory))
      if (File::Stat.method_defined?(:birthtime))
        return File.stat(directory).birthtime
      else
        return File.stat(directory).ctime
      end
    else
      # Simulator directory is not yet created - treat it as if it was created right now (happens with new iOS 9 sims)
      return Time.now
    end
  end
  
  # Deletes specified simulator
  def delete_device(device)
    execute_simctl_command("delete #{device.identifier}")
  end
  
  puts("Searching for simulators...")
  
  # Retrieve the list of existing simulators
  devices = []
  runtime = ""
  execute_simctl_command("list devices").lines.each do |line|
    case line[0]
    when '='
      # First header, skip it
    when '-'
      # Runtime header
      runtime = line.scan(/-- (.+?) --/).flatten[0]
    else
      name_and_identifier = line.scan(/\s+(.+?) \(([\w\d]+-[\w\d]+-[\w\d-]+)\)/)[0]
      name = name_and_identifier[0]
      identifier = name_and_identifier[1]
      timestamp = simulator_creation_date(identifier)
      device = SimDevice.new(runtime, name, identifier, timestamp)
      devices.push(device)
    end
  end
  
  # Sort the simulators by their creation timestamp, ascending
  devices = devices.sort { |a, b| a.timestamp <=> b.timestamp }
  
  duplicates = {}
  # Enumerate all devices except for the last one
  for i in 0..devices.count-2
    device = devices[i]
    # Enumerate all devices *after* this one (created *later*)
    for j in i+1..devices.count-1
      potential_duplicate = devices[j]
      if potential_duplicate.equivalent_to_device(device)
        duplicates[potential_duplicate] = device
        # Break out of the inner loop if a duplicate is found - if another duplicate exists,
        # it will be found when this one is reached in the outer loop
        break
      end
    end
  end
  
  if duplicates.count == 0
    puts("You don't have duplicate simulators!")
    exit()
  end
  
  puts("Looks like you have #{duplicates.count} duplicate simulator#{duplicates.count > 1 ? "s" : ""}:")
  duplicates.each_pair do |duplicate, original|
    puts
    puts("#{duplicate}")
    puts("--- duplicate of ---")
    puts("#{original}")
  end
  puts
  
  puts("Each duplicate was determined as the one created later than the 'original'.")
  
  puts("Deleting...")
  duplicates.each_key do |duplicate|
    delete_device(duplicate)
  end
  
  puts("Done!")

=begin
MIT License

Copyright (c) 2015-2019 Vlas Voloshin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
=end