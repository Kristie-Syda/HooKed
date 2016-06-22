package com.example.kristie_syda.hooked;

import com.parse.Parse;

/**
 * Created by Kristie_Syda on 6/22/16.
 */
public class Application extends android.app.Application {

    @Override
    public void onCreate() {
        super.onCreate();
        Parse.enableLocalDatastore(this);

        Parse.enableLocalDatastore(this);
        Parse.initialize(this, "Fi5lS35ykcmcoRJsCVxnYFedBkeDAHryLY9zO0Ab", "AzDqZ71sAyz4bEDSqUTOl6gDkl46MPrn4Ydw8SDN");
    }
}
