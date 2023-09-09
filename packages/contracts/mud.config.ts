import { mudConfig } from "@latticexyz/world/register";
import { resolveTableId } from "@latticexyz/config";

export default mudConfig({
  excludeSystems: [],
  systems: {
    // TODO: edit open access to false and add accessList
    // TODO: all ConfigSystem should be openAccess = false
    ShopConfigSystem: {
      name: "shop_config",
      openAccess: true,
      accessList: [],
    },
    //TODO: cannot be open access in production
    AdminConfigSystem: {
      name: "admin_system",
      openAccess: true,
    },
    UserSystem: {
      name: "user_system",
      openAccess: true,
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

    /**
     *  Buff
     *
     */

    BuffTypeConfig: {
      keySchema: {
        buffType: "uint32",
      },
      schema: {
        attribute: "uint256", // the buff attributes, optional
        extraAttributes: "uint256[]", // the extended buff values
      },
    },

    BuffConfig: {
      keySchema: {
        buffId: "bytes32",
      },
      schema: {
        buffType: "uint32", // the buff type
        buffValue: "uint256", // the buff value, eg drop rate
        duration: "uint256", // the duration of buff, in seconds
        buffExtraValues: "uint256[]", // the extended buff value
      },
    },

    BuffStatus: {
      keySchema: {
        targetType: "uint8", // 0 for pet, 1 for user, 2 for plants
        targetId: "bytes32",
        buffType: "uint32",
      },
      schema: {
        buffId: "bytes32", // the buff id, notice here only keep the last buff of same type
        startTime: "uint256", // the start time of this buff
      },
    },

    /**
     *  Cats
     *
     */

    /**
     * Cat Config
     */
    CatConfig: {
      keySchema: {},
      schema: {
        hungerConsumeRate: "uint32", // hunger consumption rate each seconds, in 1e6 precision
        funConsumeRate: "uint32", // fun consumption rate each seconds, in 1e6 precision
        baseDropRate: "uint32", // the base reward drop rate of cat, in 1e4 precision
        baseHungerCoinRate: "uint32", // the base hunger coin conversion rate of cat, in 1e4 precision
        starvingStartTime: "uint256", // the number of seconds cat can endure when hunger keep zero, after this the cat has chance to leave
        foreverFriendshipLevel: "uint32", // the friendship level of cat will never lost permanently
        funLimit: "uint32", // the fun limit of cat, in 1e6 precision
        cleanLimit: "uint32", // the clean limit of cat, in 1e6 precision
      },
    },

    CatLevelConfig: {
      keySchema: {
        level: "uint32",
      },
      schema: {
        hungerLimit: "uint32", // in 1e4 precision
        expLimit: "uint32", // in 1e4 precision
      },
    },

    CatFriendshipLevelConfig: {
      keySchema: {
        friendshipLevel: "uint32",
      },
      schema: {
        expLimit: "uint32", // in 1e4 precision
        starvingTimeLimit: "uint32", // the number of seconds cat will leave when hunger keep zero, 0 means never leave
      },
    },

    CatBornStatusConfig: {
      keySchema: {},
      schema: {
        hunger: "uint32",
        fun: "uint32",
        clean: "uint32",
      },
    },

    /**
     * Cat Status
     */

    Cats: {
      keySchema: {
        cat_id: "bytes32",
      },
      schema: {
        ownerId: "bytes32", // the user id of cat owner
        exp: "uint32", // the exp gains after last level up
        level: "uint32",
        hunger: "uint32",
        fun: "uint32",
        clean: "uint32",
        starvingTime: "uint256", // the time when cat keep zero hunger, if cat is not starving now, this value is 0
        lastUpdateTime: "uint256", // the last time to update cat hunger and fun status
      },
    },
    CatAttributes: {
      keySchema: {
        catId: "bytes32",
      },
      schema: {
        sex: "bool",
        fatherId: "bytes32",
        motherId: "bytes32",
        hobbyId: "bytes32",
        personality: "uint256",
        skin: "uint256",
        birthTime: "uint256",
      },
    },
    AutoFeederStatus: {
      keySchema: {
        catId: "bytes32",
      },
      schema: {
        lastFeedTime: "uint256", // the last time the cat is auto fed
        feedRatio: "uint32", // the ratio of auto feed, in 10000 precision, update when level up or change the number of cat
      },
    },

    /***
     *
     * User
     */

    /**
     * User Status
     */

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
        totalHungerLimit: "uint32", // the total hunger limit of all cats, in 1e4 precision
        catIds: "bytes32[]", // In game design, the max number of cats is 16 for each user
      },
    },

    UserCats: {
      keySchema: {
        userId: "bytes32",
        catId: "bytes32",
      },
      schema: {
        friendshipExp: "uint32", // the exp gains after last friendship level up
        friendshipLevel: "uint32",
        obtainTime: "uint256",
        lostTime: "uint256",
        obtainMethod: "uint8",
        status: "uint8", // 1: at home, 2: in activity, 3: lostTemp, 4: lostForever 5: transfer
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

    AutoFeederConfig: {
      keySchema: {},
      schema: {
        feedRate: "uint32", // the hunger limit percent will be fed per cat per second in 1e6 precision
      },
    },

    AutoFeederLevelConfig: {
      keySchema: {
        level: "uint32",
      },
      schema: {
        foodLimit: "uint32", // the hunger in 1e4 precision
        foodPrice: "uint32",
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
        level: "uint32",
        exp: "uint32", // the exp gains after last level up
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

    UserLevelConfig: {
      keySchema: {
        level: "uint32",
      },
      schema: {
        expLimit: "uint32", // in 1e4 precision
      },
    },

    UserCatAlbum: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        photoId: "bytes32",
        obtainTime: "uint256",
        status: "uint8",
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
        itemId: "bytes32",
      },
      schema: {
        itemNum: "uint32",
        itemStatus: "uint8",
      },
    },

    /**
     *
     * Items
     *
     */

    ItemConfig: {
      keySchema: {
        itemId: "bytes32",
      },
      schema: {
        maxItemQuantity: "uint32",
        designer: "address", // the designer of this item
      },
    },

    ItemTradableConfig: {
      keySchema: {
        itemId: "bytes32",
      },
      schema: {
        tradable: "bool",
      },
    },

    ItemBuffConfig: {
      keySchema: {
        itemId: "bytes32",
      },
      schema: {
        buffIds: "bytes32[]", // the buff ids
      },
    },

    /***
     *
     * Food
     *
     */
    FoodConfig: {
      keySchema: {
        itemId: "bytes32",
      },
      schema: {
        hunger: "uint32",
      },
    },

    /***
     *
     * Tasks
     *
     */
    TaskConfig: {
      keySchema: {
        taskId: "bytes32",
      },
      schema: {
        level: "uint32", // level required for player to unlock this task
        dupPeriod: "uint32", // dup period = 0 mean no dup, in seconds
        rewardUserExp: "uint32",
        rewardCoins: "uint256",
        rewardDiamonds: "uint256",
        status: "uint8", // 0: inactive, 1: active
      },
    },
    // need to finish all required tasks to unlock this task
    TaskRequiredTasksConfig: {
      keySchema: {
        taskId: "bytes32",
      },
      schema: {
        taskIds: "bytes32[]",
      },
    },
    TaskRequiredItemsConfig: {
      keySchema: {
        taskId: "bytes32",
      },
      schema: {
        itemIds: "bytes32[]",
        itemQuantities: "uint32[]",
        isConsumed: "bool[]", // if task need to consume the required items
      },
    },
    TaskRewardItemsConfig: {
      keySchema: {
        taskId: "bytes32",
      },
      schema: {
        itemIds: "bytes32[]",
        itemQuantities: "uint32[]",
      },
    },

    /***
     *
     * Shop
     *
     */

    /**
     *
     * Only item creator can update the store info
     *
     * if item creator is 0x0, then only game designer can update the store info
     */

    Shop: {
      keySchema: {
        itemId: "bytes32",
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

    /***
     * General Hobby Config
     */

    HobbyBasicConfig: {
      keySchema: {},
      schema: {
        hungerCatExpRate: "uint32", // the cat exp rate for each hunger, in 1e4 precision
        hungerUserExpRate: "uint32", // the user exp rate for each hunger, in 1e4 precision
      },
    },

    // TODO: if need add pause status for hobby config
    HobbyConfig: {
      keySchema: {
        hobbyId: "bytes32",
      },
      schema: {
        designer: "address",
        playerChosenTagNum: "uint8", // the number of tag can be chosen in one tier by players before the activity start
        hungerConsumptionRate: "uint32", // the hunger consumption rate in seconds, in 1e6 precision
        extraRewardNum: "uint8", // the number of extra reward items in each activity for this hobby, 0 for only one reward item each time, related to the HobbyExtraRewardConfig
        hasExtraSteps: "bool", // if this hobby has extra steps, related to the HobbyExtraStepsConfig
        hobbyAttractiveItem: "bytes32", // item id, this item can be used to attract cats has this hobby, only the creator can create this item
        requiredItems: "bytes32[]", // the items required to do this activity
      },
    },

    HobbyRandomSourceConfig: {
      keySchema: {
        hobbyId: "bytes32",
      },
      schema: {
        strictRandom: "bool", // if this hobby is strict random, if true, then the random number must always be generated by the delay blocks, this has chance to make players wait for the hobby start if they takes long time to choose the tag
        delayBlocks: "uint32", // the delay blocks for this hobby, use for randomness generation, the more the safer
      },
    },

    HobbyLevelTierConfig: {
      keySchema: {
        hobbyId: "bytes32",
        level: "uint32",
      },
      schema: {
        tier: "uint8",
      },
    },

    HobbyTierConfig: {
      keySchema: {
        hobbyId: "bytes32",
        tier: "uint8",
      },
      schema: {
        baseTime: "uint256", // the base activity time for this tier, the minimum time is 10 minutes, each 1 percent of hunger consumption rate requires at least 1 minute to consume
        baseRestTime: "uint256", // the base rest time for this tier, the minimum time is 10 minutes, each 1 percent of hunger consumption rate requires at least 1 minute to rest
        tierChosenSampleId: "bytes32", // the sample id for chosen tier
        tagChosenSampleId: "bytes32", // the sample id for chosen tag
        tierChosenRange: "uint8[]", // the tiers can be chosen under this tier
        tagChosenRange: "bytes32[]", // the tag ids for this tier
      },
    },

    HobbyRewardItemsConfig: {
      keySchema: {
        hobbyId: "bytes32",
        tier: "uint8",
        tagId: "bytes32",
      },
      schema: {
        sampleId: "bytes32", // the sample id for reward items
        itemIds: "bytes32[]",
      },
    },

    // For hobby has more than 1 types reward
    // share the same reward weight config
    HobbyExtraRewardConfig: {
      keySchema: {
        hobbyId: "bytes32",
        tier: "uint8",
        tagId: "bytes32",
        extraIndex: "uint8", // the index of extra reward, 0 for the first extra reward, 1 for the second extra reward
      },
      schema: {
        itemIds: "bytes32[]", // itemId here, 0 for no item
      },
    },

    HobbyExtraStepsConfig: {
      keySchema: {
        hobbyId: "bytes32",
        tier: "uint8",
        tagId: "bytes32",
      },
      schema: {
        extraSteps: "uint32[]", // the extra steps required to get each reward item, 0 for 1 steps in total
      },
    },

    /**
     *
     * General Hobby
     */

    HobbyLog: {
      keySchema: {
        logId: "bytes32",
      },
      schema: {
        catId: "bytes32",
        hobbyId: "bytes32",
        tier: "uint8", // the hobby tier of this activity
        tagId: "bytes32", // the tag id of this activity
        tierTagIndex: "uint32", // the item index in the tag config of a specific tier
        dropRate: "uint32", // the drop rate of this activity, 10000 for 100%
        specialEffect: "uint256", // the special effect of this activity, 0 for no special effect
        step: "uint32", // the number of finished steps of this activity
        startTime: "uint256", // the start time of this activity
        requestRandBlock: "uint256", // the block number of request random
        randomSeed: "uint256", // random seed
        endTime: "uint256", // the end time of this activity, decide when start this activity
        lastUpdateTime: "uint256", // the last update time of this activity, will update the hunger consumption and fun consumption
        status: "uint8", // 0 for not start, 1 for started but not finished, 2 for finished but not claimed, 3 for claimed reward, 4 for canceled
        rewardCoins: "uint256",
        rewardCatExp: "uint32",
        rewardUserExp: "uint32",
        rewardItems: "bytes32[]",
      },
    },

    CatHobbyStatus: {
      keySchema: {
        catId: "bytes32",
      },
      schema: {
        currentLogId: "bytes32", // the current log id of this cat,
        latestLogId: "bytes32", // the latest log id of this cat,
        lastEventFinishTime: "uint256", // the last event finish time of this cat
      },
    },

    // the hobby of next stray cat, when hobbyId is '0x0' means random in official hobbies
    // players can buy special hobby items and use it to fix the hobby of next stray cat
    StrayCatHobby: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        hobbyId: "bytes32",
      },
    },

    /**
     *
     * Weighted Sample Config
     */

    // current default sample method for the sampleId
    SampleMethodConfig: {
      keySchema: {
        sampleId: "bytes32",
      },
      schema: {
        designer: "address", // the designer of this sample config
        samplingMethod: "uint8", // 0 for no weight sampling, 1 for simple sampling, 2 for alias sampling, 3 for prefix sum sampling
      },
    },

    // used when only few items and simple weight ratio, fastest O(1) query time complexity
    SimpleSampleConfig: {
      keySchema: {
        sampleId: "bytes32",
      },
      schema: {
        indices: "uint16[]", // the index of each item in alias sampling, maximum 65535 items here
      },
    },

    // used when many items and complex weight ratio, O(1) query time complexity
    AliasSampleConfig: {
      keySchema: {
        sampleId: "bytes32",
      },
      schema: {
        rates: "uint16[]", // the rate of each bar in 10000 precision
        indices: "uint16[]", // the index of each item in alias sampling, maximum 65535 items here
      },
    },

    // used when very large items and complex weight ratio, O(log(n)) query time complexity with binary search
    PrefixSumSampleConfig: {
      keySchema: {
        sampleId: "bytes32",
      },
      schema: {
        accWeights: "uint32[]", // the accumulated weights of each item
      },
    },

    /**
     * GlobalConfig
     */

    MetaConfig: {
      keySchema: {
        uniqueKey: "bytes32",
      },
      schema: {
        name: "string",
        uri: "string",
      },
    },

    GlobalRandomSourceConfig: {
      keySchema: {},
      schema: {
        randomSource: "address",
      },
    },

    GlobalAddressConfig: {
      keySchema: {
        configKey: "bytes32",
      },
      schema: {
        configValue: "address",
      },
    },

    // using for create new id
    GlobalIDCount: {
      keySchema: {},
      schema: {
        count: "uint256",
      },
    },

    /**
     * Player Init Config
     */
    PlayerInitConfig: {
      keySchema: {},
      schema: {
        initCoins: "uint256",
        initItems: "bytes32[]",
      },
    },
  },
  modules: [],
});
