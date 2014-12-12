require 'logger'
require 'fileutils'
require 'omnistruct'
require 'open3'

module UtilityBelt
  def self.mkdir *path
    path = File.join(path)
    FileUtils.mkdir(path, :mode => 0755) unless File.directory?(path)
  end

  def self.touch *path
    path = File.join(path)
    FileUtils.touch(path)
    File.chmod(0644, path)
  end

  def self.save name, body, bin=false
    flags = 'w'
    flags += '+b' if bin

    File.open(name, flags) { |f| f << body }
  end

  def self.exec *cmd
    cmd = cmd.join(" ")

    stdout, stderr, status = Open3.capture3(cmd)

    return {
      :stdout => stdout,
      :stderr => stderr,
      :status => status
    }.to_struct(:struct)

  rescue Exception => e
    return { :stdout => "", :stderr => e.message, :status => 1 }.to_struct
  end

  def self.encrypt! src, dest, rec
    cmd = [ "gpg --recipient", rec, "--batch --no-tty --yes",
                "--output", dest, "--encrypt", src ]

    res = exec(*cmd)

    unless res.status == 0
      raise res.stderr unless res.stderr.empty?
      raise "GPG Encryption failed and I don't know why."
    end

    dest
  end

  def self.decrypt src, rec
    cmd = [ "gpg --decrypt --no-tty --recipient", rec, src ]
    res = exec(*cmd)

    unless res.status == 0
      raise res.stderr unless res.stderr.empty?
      raise "GPG Encryption failed and I don't know why."
    end

    res.stdout
  end

  def self.decrypt_to src, dest, rec
    res = self.decrypt(src, rec)
    save(dest, res)
    dest
  end

  class NullLogger < ::Logger
    def initialize(*args)
    end

    def add(*args, &block)
    end
  end
end
