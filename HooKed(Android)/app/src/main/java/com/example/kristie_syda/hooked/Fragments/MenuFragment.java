package com.example.kristie_syda.hooked.Fragments;

import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.example.kristie_syda.hooked.Activities.AchievementActivity;
import com.example.kristie_syda.hooked.Activities.MainActivity;
import com.example.kristie_syda.hooked.Activities.ProfileActivity;
import com.example.kristie_syda.hooked.Activities.ShopActivity;
import com.example.kristie_syda.hooked.R;
import com.parse.ParseUser;

/**
 * Created by Kristie_Syda on 6/22/16.
 */
public class MenuFragment extends Fragment {
    public static final String TAG = "MenuFragment.TAG";

    //FACTORY METHODS
    public static MenuFragment newInstance(){
        MenuFragment frag = new MenuFragment();
        return frag;
    }
    public MenuFragment(){
        super();
    }
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.menu_fragment,container,false);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        //Log Out Button
        Button logOut = (Button) getView().findViewById(R.id.btn_logOut);
        logOut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Log Out of parse
                ParseUser.logOut();
                ParseUser currentUser = ParseUser.getCurrentUser();
                //Present Login Screen
                Intent intent = new Intent(getActivity(),MainActivity.class);
                startActivity(intent);
            }
        });

        //View Profile Button
        Button profile = (Button) getView().findViewById(R.id.btn_play);
        profile.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), ProfileActivity.class);
                startActivity(intent);
            }
        });

        //Shop
        Button shop = (Button) getView().findViewById(R.id.btn_shop);
        shop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), ShopActivity.class);
                startActivity(intent);
            }
        });

        //Achievement
        Button achieve = (Button) getView().findViewById(R.id.btn_ach);
        achieve.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), AchievementActivity.class);
                startActivity(intent);
            }
        });
    }
}
