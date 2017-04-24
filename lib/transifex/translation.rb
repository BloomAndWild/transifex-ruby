require 'digest'

module Transifex
  class Translation
    attr_accessor :client

    def initialize(project_slug, resource_slug, language_code)
      @project_slug = project_slug
      @resource_slug = resource_slug
      @language_code = language_code
    end

    def content
      client.get("/project/#{@project_slug}/resource/#{@resource_slug}/translation/#{@language_code}/")["content"]
    end

    def strings args = {}
      client.get(
        "/project/#{@project_slug}/resource/#{@resource_slug}/translation/#{@language_code}/strings",
        args,
      )
    end

    def string key
      source_hash = Digest::MD5.hexdigest(key + ":")
      client.get(
        "/project/#{@project_slug}/resource/#{@resource_slug}/translation/#{@language_code}/string/#{source_hash}",
      )
    end

    def update_string key, translation
      source_hash = Digest::MD5.hexdigest(key + ":")
      client.put(
        "/project/#{@project_slug}/resource/#{@resource_slug}/translation/#{@language_code}/string/#{source_hash}",
        { translation: translation }.to_json,
      )
    end

    def update(content)
      client.put(
        "/project/#{@project_slug}/resource/#{@resource_slug}/translation/#{@language_code}",
        { content: content.to_json }.to_json,
      )
    end
  end
end
