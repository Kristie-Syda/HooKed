package com.example.kristie_syda.hooked.Activities;

import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;

import com.example.kristie_syda.hooked.Fragments.LeaderboardFragment;
import com.example.kristie_syda.hooked.R;

/**
 * Created by Kristie_Syda on 6/24/16.
 */
public class LeaderboardActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        this.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
        //Hide Action Bar
        ActionBar actionBar = getSupportActionBar();
        if (actionBar != null) {
            actionBar.hide();
        }

        if(savedInstanceState == null){
            LeaderboardFragment frag = LeaderboardFragment.newInstance();
            getFragmentManager().beginTransaction().replace(R.id.fake_frag,frag,LeaderboardFragment.TAG).commit();
        }
    }
}
