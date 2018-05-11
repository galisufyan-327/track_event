##
# Here are the point scales for each module
# companyuser: 1, 5, 10, 20, 50
# contract: 1, 3, 6, 10, 15
# vendor: 1, 3, 5, 10, 20
# telecom: 1, 2, 3, 5, 8
# helpticket: 1, 10, 25, 50, 100
# assets: 1, 5, 20, 50, 100
#
# points per level for each: 100, 300, 600, 1000, 1500
# total point level: 600, 1800, 3600, 6000, 9000
module RewardConstants
  extend ActiveSupport::Concern
  included do
    COMPANYUSER_CREATED_REWARDS = [{count: 0, points: 0}, { count: 1, points: 100}, {count: 5, points: 300},
                                   {count: 10, points: 600}, {count: 20, points: 1000}, {count: 50, points: 1500}].freeze

    MANAGEDASSET_CREATED_REWARDS = [{count: 0, points: 0}, { count: 1 , points: 100}, {count: 5 , points: 300},
                                     {count: 20 , points: 600}, {count: 50 , points: 1000},
                                     {count: 100 , points: 1500}].freeze

    CONTRACT_CREATED_REWARDS = [{count: 0, points: 0}, { count: 1, points: 100}, {count: 3, points: 300},
                                {count: 6, points: 600}, {count: 10, points: 1000},
                                {count: 15, points: 1500}].freeze

    VENDOR_CREATED_REWARDS = [{count: 0, points: 0}, { count: 1, points: 100}, {count: 3, points: 300},
                              {count: 5, points: 600}, {count: 10, points: 1000},
                              {count: 20, points: 1500}].freeze

    TELECOMSERVICE_CREATED_REWARDS = [{count: 0, points: 0}, { count: 1, points: 100}, {count: 2, points: 300},
                                      {count: 3, points: 600}, {count: 5, points: 1000},
                                      {count: 8, points: 1500}].freeze

    HELPTICKET_CREATED_REWARDS = [{count: 0, points: 0}, { count: 1, points: 100}, {count: 10, points: 300},
                                  {count: 25, points: 600}, {count: 50, points: 1000},
                                  {count: 100, points: 1500}].freeze

    TEMP_REWARD_COUNTS = [{key: "Contract", count: 0}, {key: "TelecomService", count: 0},
                          {key: "Vendor", count: 0}, {key: "HelpTicket", count: 0},
                          {key: "CompanyUser", count: 0}, {key: "ManagedAsset", count: 0}].freeze

    TARGET_TYPES = ['Contract', 'CompanyUser', 'ManagedAsset', 'HelpTicket', 'Vendor', 'TelecomService']
  end
end
