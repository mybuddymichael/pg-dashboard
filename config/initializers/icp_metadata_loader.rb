class IcpMetadataLoader
  def self.run
    Icp.all.collect do |icp|
      existing_icp_metadata = icp.icp_metadata
      Rails.logger.info "Metadata for #{icp.icp_name} is currently #{existing_icp_metadata}."
      if !existing_icp_metadata
        icp_metadata = IcpMetadata.new
        icp_metadata.icp_id = icp.id
        icp_metadata.save
        Rails.logger.info "Metadata saved for #{icp.icp_name}."
      end
    end
  end
end

begin
  IcpMetadataLoader.run
rescue ActiveRecord::StatementInvalid
  # The migrations are probably being run right now.
end
