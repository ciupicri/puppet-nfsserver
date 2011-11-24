# Based on code from
# puppet-modules.git.puzzle.ch/module-nfsd/lib/puppet/parser/functions
#
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
# Matthias Imsand imsand+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute
# it and/or modify it under the terms of the GNU
# General Public License version 3 as published by
# the Free Software Foundation.

module Puppet::Parser::Functions
  newfunction(:gen_client_list, :type => :rvalue) do |args|
    aug_cmd = Array.new
    clients = Array.new
    options = Array.new
    clients = args[0]
    options = args[1]
    dir = args[2]
    aug_cmd << "rm dir[.='#{dir}']"
    #aug_cmd << "insert dir after \"/dir[last()]\""
    aug_cmd << "set dir[last()+1] #{dir}"
    clients.each do |client|
      aug_cmd << "set dir[last()]/client[last()+1] #{client}"
      options.each do |option|
        aug_cmd << "set dir[last()]/client[last()]/option[last()+1] #{option}"
      end
    end
    return aug_cmd
  end
end
