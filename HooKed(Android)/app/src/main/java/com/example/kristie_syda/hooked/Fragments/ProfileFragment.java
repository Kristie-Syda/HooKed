package com.example.kristie_syda.hooked.Fragments;

import android.app.Fragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.example.kristie_syda.hooked.R;
import com.parse.FindCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.List;


/**
 * Created by Kristie_Syda on 6/23/16.
 */
public class ProfileFragment extends Fragment {
    public static final String TAG = "ProfileFragment.TAG";

    //FACTORY METHODS
    public static ProfileFragment newInstance(){
        ProfileFragment frag = new ProfileFragment();
        return frag;
    }
    public ProfileFragment(){
        super();
    }
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.profile_fragment,container,false);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        //TextViews
        final TextView username = (TextView) getView().findViewById(R.id.pUsername);
        final TextView highscore = (TextView) getView().findViewById(R.id.pScore);
        final TextView bank = (TextView) getView().findViewById(R.id.pBank);

        //Get current user
        ParseUser current = ParseUser.getCurrentUser();
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Score");
        query.whereEqualTo("Player", current);
        query.findInBackground(new FindCallback<ParseObject>() {
            ParseObject object;
            String userName;
            String highScore;
            String mBank;

            @Override
            public void done(List<ParseObject> objects, ParseException e) {
               for(int i=0; i<objects.size(); i++){
                   object = objects.get(0);
               }

                //Get info from object
                userName = (String) object.get("UserName");
                highScore = String.valueOf(object.get("HighScore"));
                mBank = String.valueOf(object.getInt("Coins"));

                //Fill in labels
                username.setText(userName);
                highscore.setText(highScore);
                bank.setText(mBank);
            }
        });

        //Back Button
        Button btn_back = (Button) getView().findViewById(R.id.btn_pBack);
        btn_back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().finish();
            }
        });
    }
}
