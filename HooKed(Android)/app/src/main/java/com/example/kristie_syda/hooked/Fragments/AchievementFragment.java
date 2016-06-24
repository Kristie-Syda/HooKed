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

import com.example.kristie_syda.hooked.R;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.List;

/**
 * Created by Kristie_Syda on 6/23/16.
 */
public class AchievementFragment extends Fragment {
    public static final String TAG = "AchievementFragment.TAG";
    private int mA1;
    private int mA2;
    private int mA3;
    private int mA4;
    private String m1;
    private String m2;
    private String m3;
    private String m4;

    //FACTORY METHODS
    public static AchievementFragment newInstance(){
        AchievementFragment frag = new AchievementFragment();
        return frag;
    }
    public AchievementFragment(){
        super();
    }
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.achieve_layout,container,false);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        //Back button
        Button back = (Button) getView().findViewById(R.id.btn_aBack);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().finish();
            }
        });

        //Grab data from parse
        ParseUser current = ParseUser.getCurrentUser();
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Achievements");
        query.whereEqualTo("Player", current);
        try {
            List<ParseObject> objects = query.find();
            for(ParseObject object : objects){
                m1 = ""+object.getBoolean("A1");
                m2 = ""+object.getBoolean("A2");
                m3 = ""+object.getBoolean("A3");
                m4 = ""+object.getBoolean("A4");
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        //Manually go and add in images by parse data
        if(m1.equals("true")){
            mA1 = R.drawable.green;
        } else {
            mA1 = R.drawable.grey;
        }
        if (m2.equals("true")) {
            mA2 = R.drawable.green;
        } else {
            mA2 = R.drawable.grey;
        }
        if (m3.equals("true")) {
            mA3 = R.drawable.green;
        } else {
            mA3 = R.drawable.grey;
        }
        if (m4.equals("true")) {
            mA4 = R.drawable.green;
        } else {
            mA4 = R.drawable.grey;
        }
        //Data
        String[] title = new String[]{"StockPile", "Decade", "Five-spots", "Full Closet"};
        String[] details = new String[]{"Earn 1,000 points", "Earn 2,000 points", "Earn 5,000 points", "Own every outfit in the shop"};
        int[] status = new int[]{mA1,mA2,mA3,mA4};
        //Set up ListView
        ListView list = (ListView) getView().findViewById(R.id.listView1);
        list.setAdapter(new AchieveAdapter(title,details,status));
    }

    public class AchieveAdapter extends BaseAdapter {
        private LayoutInflater inflater = null;
        String[] mTitle;
        String[] mDetails;
        int[] mStatus;

        public AchieveAdapter(String[] title,String[] details, int[] status){
            mTitle = title;
            mDetails = details;
            mStatus = status;
            inflater = ( LayoutInflater )getActivity().
                    getSystemService(getActivity().LAYOUT_INFLATER_SERVICE);
        }
        public class Holder {
            TextView titleView;
            ImageView statusView;
            TextView detailView;
        }

        //Required Methods
        @Override
        public int getCount() {
            return mTitle.length;
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
            row = inflater.inflate(R.layout.achieve_view,null);
            holder.titleView = (TextView) row.findViewById(R.id.achieveTitle);
            holder.statusView = (ImageView) row.findViewById(R.id.imageView2);
            holder.detailView = (TextView) row.findViewById(R.id.achieveDetails);
            //Fill in data
            holder.titleView.setText(mTitle[position]);
            holder.detailView.setText(mDetails[position]);
            holder.statusView.setImageResource(mStatus[position]);
            return row;
        }
    }
}
