package com.example.kristie_syda.hooked;

import android.app.Fragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.parse.ParseObject;

/**
 * Created by Kristie_Syda on 6/22/16.
 */
public class LoginFragment extends Fragment {
    public static final String TAG = "LoginFragment.TAG";

    //FACTORY METHODS
    public static LoginFragment newInstance(){
        LoginFragment frag = new LoginFragment();
        return frag;
    }
    public LoginFragment(){
        super();
    }
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.login_fragment,container,false);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        ParseObject testObject = new ParseObject("TestObject");
        testObject.put("foo", "nosey");
        testObject.saveInBackground();
    }
}
