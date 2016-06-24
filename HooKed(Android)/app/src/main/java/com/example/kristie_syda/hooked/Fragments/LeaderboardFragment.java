package com.example.kristie_syda.hooked.Fragments;

import android.app.Fragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.example.kristie_syda.hooked.LeaderObject;
import com.example.kristie_syda.hooked.R;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;


import java.util.ArrayList;
import java.util.List;

/**
 * Created by Kristie_Syda on 6/24/16.
 */
public class LeaderboardFragment extends Fragment {
    public static final String TAG = "LeaderboardFragment.TAG";
    private LeaderObject leadObject;
    private ArrayList<LeaderObject> leadList = new ArrayList<>();
    int mRank = 0;

    //FACTORY METHODS
    public static LeaderboardFragment newInstance(){
        LeaderboardFragment frag = new LeaderboardFragment();
        return frag;
    }
    public LeaderboardFragment(){
        super();
    }
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.leaderboard_fragment,container,false);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        //Back button
        Button back = (Button) getView().findViewById(R.id.btn_lBack);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().finish();
            }
        });

        //Get data from parse
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Score");
        query.orderByDescending("HighScore");
        try {
            List<ParseObject> objects  = query.find();
            //Loop through objects
            for(ParseObject object : objects){
                String user = object.getString("UserName");
                System.out.print("////////////////// user = " + user);
                int score = object.getInt("HighScore");
                mRank = mRank + 1;
                leadObject = new LeaderObject(user,score,mRank);
                leadList.add(leadObject);
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        System.out.println("////////////////// leadList = " + (leadList));
        ListView list = (ListView) getView().findViewById(R.id.listView2);
        list.setAdapter(new LeaderAdapter(leadList));
    }

    //Leaderboard Custom Adapter
    public class LeaderAdapter extends BaseAdapter {
        private LayoutInflater inflater = getActivity().getLayoutInflater();
        ArrayList <LeaderObject> mList = new ArrayList<LeaderObject>();

        //Constructor
        public LeaderAdapter(ArrayList<LeaderObject> list){
           mList = list;
        }

        //Holder Class
        public class Holder {
            TextView userView;
            TextView rankView;
            TextView scoreView;
        }
        @Override
        public int getCount() {
            return mList.size();
        }
        @Override
        public Object getItem(int position) {
            return position;
        }
        @Override
        public long getItemId(int position) {
            return position;
        }
        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            Holder holder = new Holder();
            View row;
            row = inflater.inflate(R.layout.leader_view,null);
            holder.userView = (TextView) row.findViewById(R.id.leaderUser);
            holder.scoreView = (TextView) row.findViewById(R.id.leaderRank);
            holder.rankView = (TextView) row.findViewById(R.id.leaderScore);
            //Fill in data
            holder.userView.setText(mList.get(position).getmUsername());
            holder.rankView.setText(String.valueOf(mList.get(position).getmRank()));
            holder.scoreView.setText(String.valueOf(mList.get(position).getmScore()));
            return row;
        }
    }
}
