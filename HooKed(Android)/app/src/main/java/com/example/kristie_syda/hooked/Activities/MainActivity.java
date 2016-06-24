package com.example.kristie_syda.hooked.Activities;

import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.example.kristie_syda.hooked.Fragments.LoginFragment;
import com.example.kristie_syda.hooked.R;
import com.parse.ParseUser;

public class MainActivity extends AppCompatActivity {

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
            ParseUser current = ParseUser.getCurrentUser();
            //Nobody is logged in
            if (current == null) {
                //Present Login Fragment
                LoginFragment frag = LoginFragment.newInstance();
                getFragmentManager().beginTransaction().replace(R.id.fake_frag,frag,LoginFragment.TAG).commit();
            } else {
                //Present Menu Fragment
                Intent intent = new Intent(this, MenuActivity.class);
                startActivity(intent);
            }
        }
    }
}
