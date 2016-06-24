package com.example.kristie_syda.hooked.Fragments;

import android.app.AlertDialog;
import android.app.Fragment;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.example.kristie_syda.hooked.R;
import com.parse.FindCallback;
import com.parse.GetCallback;
import com.parse.ParseException;
import com.parse.ParseObject;
import com.parse.ParseQuery;
import com.parse.ParseUser;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


/**
 * Created by Kristie_Syda on 6/23/16.
 */
public class ShopFragment extends Fragment {
    public static final String TAG = "ShopFragment.TAG";
    private String mCoins;
    private ArrayList mCloset = new ArrayList();
    private String objectId;
    private TextView coinLbl;

    //FACTORY METHODS
    public static ShopFragment newInstance(){
        ShopFragment frag = new ShopFragment();
        return frag;
    }
    public ShopFragment(){
        super();
    }
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.shop_fragment,container,false);
        return view;
    }
    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        GridView mGrid;
        //Shop Data
        String [] price = {"100","100","100","50","500","300","200","400"};
        int [] img = {R.drawable.blueshirt,R.drawable.redshirt,R.drawable.yellowshirt,R.drawable.beeniehat,R.drawable.drinkhat,R.drawable.vikinghat,R.drawable.santahat,R.drawable.spinhat};
        String [] imgName = {"img_blueShirt","img_redShirt","img_yellowShirt","img_beenieHat","img_drinkHat","img_vikingHat","img_santaHat","img_spinHat"};
        //GridView
        mGrid = (GridView) getView().findViewById(R.id.gridView1);
        mGrid.setAdapter(new ShopAdapter(price, imgName, img));
        //Back button & listener
        Button back = (Button) getView().findViewById(R.id.btn_sBack);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().finish();
            }
        });

        //Get Coins and fill in coin label
        coinLbl = (TextView) getView().findViewById(R.id.coins);
        ParseUser current = ParseUser.getCurrentUser();
        ParseQuery<ParseObject> query = ParseQuery.getQuery("Score");
        query.whereEqualTo("Player", current);
        query.findInBackground(new FindCallback<ParseObject>() {
            ParseObject object;
            @Override
            public void done(List<ParseObject> objects, ParseException e) {
                for (int i = 0; i < objects.size(); i++) {
                    object = objects.get(0);
                }
                //Get info from object
                mCoins = String.valueOf(object.getInt("Coins"));
                mCloset = (ArrayList) object.get("Closet");
                System.out.println(mCloset);
                objectId = object.getObjectId();
                //Fill in label
                coinLbl.setText(mCoins);
            }
        });
    }
    //Can Buy Method
    public void CanBuy(final String img, String coins){
        final int price = Integer.parseInt(coins);
        final int bank = Integer.parseInt(mCoins);

        //if price is less than bank - can buy
        if(price < bank){
            //Ask user
            AlertDialog.Builder Alert = new AlertDialog.Builder(getActivity());
            Alert.setTitle("Alert");
            Alert.setMessage("Are you sure you want to buy this item?");
            Alert.setNegativeButton("No", null);
            Alert.setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {

                    //User already owns item
                    if(mCloset.contains(img)){
                        AlertDialog.Builder alert2 = new AlertDialog.Builder(getActivity());
                        alert2.setTitle("Alert");
                        alert2.setMessage("Already own this item");
                        alert2.setNegativeButton("Okay", null);
                        alert2.show();

                    } else {
                        //Buy item
                        final int newCoins = (bank - price);
                        //Add to parse
                        ParseQuery query = ParseQuery.getQuery("Score");
                        query.getInBackground(objectId, new GetCallback<ParseObject>(){

                            @Override
                            public void done(ParseObject object, ParseException e) {
                                if(e == null){
                                    object.put("Coins",newCoins);
                                    object.addUnique("Closet", img);
                                    object.saveInBackground();
                                    coinLbl.setText(String.valueOf(newCoins));
                                    Toast.makeText(getActivity(), "Item Bought", Toast.LENGTH_SHORT).show();
                                }
                            }
                        });
                    }
                }
            });
            Alert.show();

        } else {
            //Inform user not enough coins
            AlertDialog.Builder Alert = new AlertDialog.Builder(getActivity());
            Alert.setTitle("Alert");
            Alert.setMessage("Not enough coins");
            Alert.setNegativeButton("Okay", null);
            Alert.show();
        }
    }
    //Shop Adapter
    public class ShopAdapter extends BaseAdapter {
        private LayoutInflater inflater=null;
        String[] results;
        String[] prices;
        int[] pics;

        public ShopAdapter(String[] priceList,String[] nameList, int[] imgList){
            results = nameList;
            pics = imgList;
            prices = priceList;
            inflater = ( LayoutInflater )getActivity().
                    getSystemService(getActivity().LAYOUT_INFLATER_SERVICE);
        }
        public class Holder {
            TextView price;
            ImageView img;
            String imgName;
        }

        @Override
        public int getCount() {
            return pics.length;
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
        public View getView(final int position, View convertView, ViewGroup parent) {
            Holder holder = new Holder();
            View row;

            row = inflater.inflate(R.layout.items_view,null);
            holder.price = (TextView) row.findViewById(R.id.price);
            holder.img = (ImageView) row.findViewById(R.id.imageView1);
            holder.imgName = String.valueOf(pics[position]);

            holder.img.setImageResource(pics[position]);
            holder.price.setText(prices[position]);

            row.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    CanBuy(results[position],prices[position]);
                }
            });
            return row;
        }
    }
}
