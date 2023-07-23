import { mudConfig } from "@latticexyz/world/register";
import { resolveTableId } from "@latticexyz/config";

export default mudConfig({
  systems: {
    // TODO: edit open access to false and add accessList
    // TODO: all ConfigSystem should be openAccess = false
    ShopConfigSystem: {
      name: "shop_config",
      openAccess: true,
      accessList: [],
    },
    //TODO: cannot be open access in production
    AdminSystem: {
      name: "admin_system",
      openAccess: true,
    },
    UserSystem: {
      name: "user_system",
      openAccess: true,
    },
    TimeZoneSystem: {
      name: "time_zone_system",
      openAccess: false,
    },
    PeriodEventsSystem: {
      name: "period_events",
      openAccess: false,
    },
    QuantityHelperSystem: {
      name: "quantity_helper",
      openAccess: false,
    },
  },
  tables: {
    /**
     *  General
     *
     */
    //  allow mapping from multiple addresses to one user_id
    Address2User: {
      keySchema: {
        userAddress: "address",
      },
      schema: {
        userId: "bytes32",
      },
    },
    // use for traditional erc20/721 assets to bind
    UserMainAddress: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        userAddress: "address",
      },
    },

    ItemList: {
      keySchema: {
        event_hash: "bytes32",
      },
      schema: {
        itemId: "uint256",
        itemNum: "uint256",
      },
    },

    Tradable: {
      keySchema: {
        itemId: "bytes32",
      },
      schema: {
        tradable: "bool",
      },
    },

    /**
     *  Cats
     *
     */

    Cats: {
      keySchema: {
        cat_id: "bytes32",
      },
      schema: {
        sex: "bool",
        fatherId: "uint256",
        motherId: "uint256",
        personality: "uint256",
        skin: "uint256",
        exp: "uint32",
        level: "uint32",
        hunger: "uint32",
        fun: "uint32",
        health: "uint32",
        cleanLevel: "uint8",
        birthTime: "uint256",
      },
    },
    CatBuff: {
      keySchema: {
        catId: "uint256",
      },
      schema: {
        buffId: "uint256",
        startTime: "uint256",
        duration: "uint256",
      },
    },

    UserAdoptions: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        adoptionNum: "uint32",
      },
    },

    UserCatList: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        catIds: "bytes32[]", // In game design, the max number of cats is 8 for each user
      },
    },

    UserCats: {
      keySchema: {
        userId: "bytes32",
        catId: "bytes32",
      },
      schema: {
        friendship: "uint32",
        obtainTime: "uint256",
        lostTime: "uint256",
        obtainMethod: "uint8",
        status: "uint8", // 1: at home, 2: in travel, 3: lost, 4: transfer
      },
    },

    CatConfig: {
      keySchema: {
        catLevel: "uint32",
      },
      schema: {
        hungerLimit: "uint32",
        funLimit: "uint32",
        expLimit: "uint32",
      },
    },

    /**
     *  Room
     *
     */

    UserRoomExpansion: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        inDoorExpandLevel: "uint32",
        outDoorExpandLevel: "uint32",
      },
    },

    AutoFeeder: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        // left food in auto feeder
        hunger: "uint32",
        // auto feeder level
        level: "uint32",
        // last time to fill food
        lastFillFeederTime: "uint256",
        // last feed time
        lastFeedTime: "uint256",
        // The cats have been fed in last time
        lastFeedCats: "uint256[]",
      },
    },

    /**
     *  User
     *
     */
    UserStatus: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        coinBalance: "uint256",
        diamondBalance: "uint256",
        exp: "uint32",
        // if user timezone is -7 then the initial timeZoneOffset value is 7*60*60 and timeZoneSign is false
        // however if user increase timezone then, the offset will be delay to the next day
        // eg. user change timezone from -7 to 9,
        // then the timeZoneOffset will be abs(9*60*60 - 24*60*60) = 15*60*60 and the timeZoneSign is false
        // then user need to wait 8 more hours for events
        // if user decrease timezone, there is no delay
        // eg. user change timezone from -7 to -8,
        // then the timeZoneOffset will be 8*60*60 while the timeZoneSign is false, and user need to wait 1 more hour for events
        timeZoneSign: "bool", // true for +, false for -
        timeZoneOffset: "uint32",
        nickName: "string",
      },
    },

    UserCatAlbum: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        photoId: "uint256",
        obtainTime: "uint256",
        status: "uint8",
        catIds: "uint256[]",
      },
    },

    /**
     *
     * Travel
     *
     */
    Travel: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        travelId: "uint256",
        spotId: "uint256",
        travelStatus: "uint8",
        travelType: "uint8",
        rewardItemsHash: "bytes32",
        hunger: "uint32",
        fun: "uint32",
        originPhotoId: "uint256", // photo without cat
        startTime: "uint256",
        endTime: "uint256",
        startWaitingDuration: "uint256", // waiting for the travel start in minutes
        foodId: "uint256",
        backpackItemsHash: "bytes32",
        randSeed: "uint256", // random seed for this travel
        candidateCats: "uint256[]",
        catIds: "uint256[]",
      },
    },

    /***
     *
     * Items
     *
     */
    UserItems: {
      keySchema: {
        userId: "bytes32",
        itemId: "uint256",
      },
      schema: {
        itemNum: "uint32",
        itemStatus: "uint8",
      },
    },

    ItemConfig: {
      keySchema: {
        itemId: "uint256",
      },
      schema: {
        maxItemQuantity: "uint32",
        name: "string",
        uri: "string",
      },
    },

    /***
     *
     * Food
     *
     */
    FoodConfig: {
      keySchema: {
        itemId: "uint256",
      },
      schema: {
        hunger: "uint32",
        travelDropRate: "uint32",
      },
    },

    /***
     *
     * Tasks
     *
     */
    TaskConfig: {
      keySchema: {
        taskId: "uint256",
      },
      schema: {
        level: "uint32",
        dupPeriod: "uint32", // dup period = 0 mean no dup
        rewardExp: "uint32",
        rewardCoins: "uint256",
        rewardDiamonds: "uint256",
        itemConsumed: "bool", // if task need to consume the required items
        itemIds: "uint256[]",
        itemQuantities: "uint32[]",
        rewardItemIds: "uint256[]",
        rewardItemQuantities: "uint32[]",
        uri: "string",
      },
    },
    // Chores are tasks has no requirement
    //TODO: Need to enable
    ChoresConfig: {
      keySchema: {
        choreId: "uint256",
      },
      schema: {
        choreType: "uint8",
        choreReward: "uint256",
        choreRewardType: "uint8",
        choreRewardItemsHash: "bytes32",
        choreRewardItems: "uint256[]",
        choreRewardItemsNum: "uint256[]",
        choreName: "string",
        choreDescription: "string",
      },
    },

    /***
     *
     * Shop
     *
     */
    Shop: {
      keySchema: {
        itemId: "uint256",
      },
      schema: {
        itemCoinPrice: "uint256",
        itemDiamondPrice: "uint256",
        itemTokenPrice: "uint256",
        itemUnlockLevel: "uint32",
        itemDailyLimit: "uint32",
        itemWeeklyLimit: "uint32",
        itemMonthlyLimit: "uint32",
        itemForeverLimit: "uint32",
      },
    },

    /**
     *
     * Event times recorder
     */

    // record the times of a user's event in a time unit
    EventTimes: {
      keySchema: {
        userId: "bytes32",
        eventId: "bytes32",
        timeUnit: "uint32", // 0 for day, 1 for week, 2 for month, 3 for year, 4 for forever
        unitNum: "uint32", // the number of time unit, if timeUNit is forever then unitNum is 0
      },
      schema: {
        times: "uint32",
      },
    },

    /**
     * GlobalConfig
     */
    GlobalAddressConfig: {
      keySchema: {
        configKey: "bytes32",
      },
      schema: {
        configValue: "address",
      },
    },
  },
  modules: [
    {
      name: "KeysInTableModule",
      root: true,
      args: [resolveTableId("Address2User")],
    },
    {
      name: "UniqueEntityModule",
      root: true,
      args: [resolveTableId("Address2User")],
    },
  ],
});
