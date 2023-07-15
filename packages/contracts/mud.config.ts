import { mudConfig } from "@latticexyz/world/register";
import { resolveTableId } from "@latticexyz/config";

export default mudConfig({
  systems: {
    CatSystem: {
      name: "cat_system",
      openAccess: true,
    },
    // TODO: edit open access to false and add accessList
    ShopManagerSystem: {
      name: "shop_manager",
      openAccess: true,
      accessList: [],
    },
    UserSystem: {
      name: "user_system",
      openAccess: true,
    },
    ShopSystem: {
      name: "shop_system",
      openAccess: true,
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
     *  Cat
     *
     */

    Cat: {
      keySchema: {
        cat_id: "uint256",
      },
      schema: {
        sex: "bool",
        weight: "uint32",
        fatherId: "uint256",
        motherId: "uint256",
        personality: "uint256",
        skin: "uint256",
        exp: "uint256",
        hunger: "uint32",
        fun: "uint32",
        health: "uint32",
        cleanLevel: "uint8",
        adoptionAge: "uint32",
        birthDate: "uint32",
        name: "string",
      },
    },
    CatBuff: {
      keySchema: {
        catId: "uint256",
      },
      schema: {
        buffId: "uint256",
        startTime: "uint32",
        duration: "uint32",
      },
    },
    CatUserRelation: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        catId: "uint256",
        friendship: "uint32",
        obtainTime: "uint32",
        lostTime: "uint32",
        obtainMethod: "uint8",
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
        lastFillFeederTime: "uint32",
        // last feed time
        lastFeedTime: "uint32",
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
        experience: "uint256",
        nickName: "string",
        // if user timezone is -7 then the initial timeZoneOffset value is -7*60*60
        // however if user increase timezone then, the offset will be delay to the next day
        // eg. user change timezone from -7 to 9,
        // then the timeZoneOffset will be 9*60*60 - 24*60*60 = -15*60*60, then user need to wait 8 more hours for events
        // if user decrease timezone, there is no delay
        // eg. user change timezone from -7 to -8,
        // then the timeZoneOffset will be -8*60*60, and user need to wait 1 more hour for events
        timeZoneOffset: "int32",
      },
    },

    UserCatAlbum: {
      keySchema: {
        userId: "bytes32",
      },
      schema: {
        photoId: "uint256",
        obtainTime: "uint32",
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
        startTime: "uint32",
        endTime: "uint32",
        startWaitingDuration: "uint32", // waiting for the travel start in minutes
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
      },
      schema: {
        itemId: "uint256",
        itemNum: "uint256",
        itemStatus: "uint8",
      },
    },

    ItemConfig: {
      keySchema: {
        itemId: "uint256",
      },
      schema: {
        maxHoldNum: "uint32",
        name: "string",
      },
    },

    /***
     *
     *
     *
     */

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
        itemUnlockExp: "uint32",
        itemDailyBuyLimit: "uint32",
        itemWeeklyBuyLimit: "uint32",
        itemMonthlyBuyLimit: "uint32",
        itemForeverBuyLimit: "uint32",
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
