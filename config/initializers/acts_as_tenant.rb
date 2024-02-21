ActsAsTenant.configure do |config|
  config.require_tenant = false

  # Customize the query for loading the tenant in background jobs
  config.job_scope = ->{ all }

  config.tenant_change_hook = lambda do |tenant|
    if tenant.present?
      ActiveRecord::Base.connection.execute(ActiveRecord::Base.sanitize_sql_array(["SET rls.team_id = ?;", tenant.id]))
      Rails.logger.info "Changed tenant to " + [tenant.id, tenant.name].to_json
    end
  end

end
