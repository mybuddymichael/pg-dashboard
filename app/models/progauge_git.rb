class ProgaugeGit < ActiveResource::Base
  def self.repo
    Grit::Repo.new('~/workspace/scada')
  end
end
