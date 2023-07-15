import { mudConfig } from "@latticexyz/world/register";
import { resolveTableId } from "@latticexyz/config";
 

export default mudConfig({
  
  systems: {
    CatSystem: {
      name: "cat_system",
      openAccess: true,
    },
    // TODO: edit open access to false and add accessList
    StoreManagerSystem: {
      name: "store_manager",
      openAccess: true,
      accessList: []
    }
  },
  tables: {
    /**
     *  General
     * 
     */
    //  allow mapping from multiple addresses to one user_id
    Address2User: {
      keySchema: {
        user_address: "address",
      },
      schema: {
        user_id: "bytes32",
      }
    },
    // use for traditional erc20/721 assets to bind
    UserMainAddress: {
      keySchema: {
        user_id: "bytes32",
      },
      schema: {
        user_address: "address",
      }
    },

    ItemList: {
      keySchema: {
        event_hash: "bytes32",
      },
      schema: {
        item_id: "uint256",
        item_num: "uint256",
      }
    },


    Tradable: {
      keySchema: {
        item_id: "bytes32",
      },
      schema: {
        tradable: "bool",
      }
    },

    /**
     *  Cat
     * 
     */

    Cat: {
      keySchema: {
        cat_id: "uint256"
      },
      schema: {
        sex: "bool",
        weight: "uint32",
        father_id: "uint256",
        mother_id: "uint256",
        personality: "uint256",
        skin: "uint256",
        exp: "uint256",
        hunger: "uint32",
        fun: "uint32",
        health: "uint32",
        clean_level: "uint8",
        adoption_age: "uint32",
        birth_date: "uint32",
        name: "string",
      }
    },
    CatBuff: {
      keySchema: {
        cat_id: "uint256"
      },
      schema: {
        buff_id: "uint256",
        start_time: "uint32",
        duration: "uint32",
      }
    },
    CatUserRelation: {
      keySchema: {
        user_id: "bytes32",
      },
      schema: {
        cat_id: "uint256",
        friendship: "uint32",
        obtain_time: "uint32",
        lost_time: "uint32",
        obtain_method: "uint8",
      }
    },


    /**
     *  Room
     * 
     */

    UserRoomExpansion: {
      keySchema: {
        user_id: "bytes32",
      },
      schema: {
        in_door_expand_level: "uint32",
        out_door_expand_level: "uint32",
      }
    },

    AutoFeeder: {
      keySchema: {
        user_id: "bytes32",
      },
      schema: {
        // left food in auto feeder
        hunger: "uint32",
        // auto feeder level
        level: "uint32",
        // last time to fill food
        last_fill_feeder_time: "uint32",
        // last feed time
        last_feed_time: "uint32",
        // The cats have been fed in last time
        last_feed_cats: "uint256[]",
      }
    },

    /**
     *  User
     * 
     */
    UserStatus: {
      keySchema: {
        user_id: "bytes32",
      },
      schema: {
        coin_balance: "uint256",
        token_balance: "uint256",
        home_exp: "uint256",
        nick_name: "string",
      }
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
          }
    },

    /**
     * 
     * Travel
     * 
     */
    Travel: {
      keySchema: {
        user_id: "bytes32",
      },
      schema: {
        travel_id: "uint256",
        spot_id: "uint256",
        travel_status: "uint8",
        travel_type: "uint8",
        reward_items_hash: "bytes32",
        hunger: "uint32",
        fun: "uint32",
        origin_photo_id: "uint256", // photo without cat
        start_time: "uint32",
        end_time: "uint32",
        start_waiting_duration: "uint32", // waiting for the travel start in minutes
        food_id: "uint256",
        backpack_items_hash: "bytes32",
        rand_seed: "uint256", // random seed for this travel
        candidate_cats: "uint256[]",
        cat_ids: "uint256[]",
      }
    },

    /***
     * 
     * Items
     * 
     */
    UserItems: {
      keySchema: {
        user_id: "bytes32",
      },
      schema: {
        item_id: "uint256",
        item_num: "uint256",
        item_status: "uint8"
      }
    },

    /***
     * 
     * 
     * 
     */

    /***
     * 
     * Store
     * 
     */
    Store: {
      keySchema: {
        item_id: "uint256",
      },
      schema: {
        item_coin_price: "uint256",
        item_diamond_price: "uint256",
        item_daily_buy_limit: "uint32",
        item_weekly_buy_limit: "uint32",
        item_monthly_buy_limit: "uint32",
        item_forever_buy_limit: "uint32",
      }
    }
  },
  modules: [
    {
      name: "KeysInTableModule",
      root: true,
      args: [resolveTableId("Address2User")],
    },
  ],
   


});
