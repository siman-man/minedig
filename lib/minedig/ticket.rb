# encoding: utf-8

module Minedig
  # Redmineのチケットに関する処理をまとめたもの
  class Ticket < Project
    attr_reader :ticket

    def initialize(ticket: nil, host: nil, api_key: nil)
      @host = host
      @api_key = api_key
      @ticket = ticket
      @update_data = Hash.new
      @update_data["issue"] = Hash.new
    end

    # get ticket property list
    # @return [Array] list of ticket property
    def properties
      ticket.singleton_methods
    end

    # @param [Symbol] property name
    def [](name)
      self.send(name)
    end

    def description
      ticket["description"]
    end

    def id
      ticket["id"]
    end

    def description=(content)
      ticket["description"] = content
      update_data["issue"]["description"] = content
    end

    def status
      ticket.status["name"]
    end

    def status_id
      ticket.status["id"]
    end

    def project
      ticket.project["name"]
    end

    def project_id
      ticket.project["id"]
    end

    def priority
      ticket.priority["name"]
    end

    def priority_id
      ticket.priority["id"]
    end

    def subject
      ticket.subject
    end

    def subject=(title)
      ticket.subject = title
      update_data["issue"]["subject"] = title
    end

    def estimated_hours
      ticket.estimated_hours
    end

    def to_json
      ticket.to_json
    end

    def update
      json = JSON.generate(update_data)
      puts json
      query = Minedig::Query::create(host: host, path: "/issues/#{id}.json")

      puts query

      response = Minedig::Query::send(query: query, api_key: api_key, method: :put, data: json)
    end

    private
    def update_data
      @update_data
    end
  end
end