package com.example.kristie_syda.hooked;

import android.app.Fragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

/**
 * Created by Kristie_Syda on 6/22/16.
 */
public class RegisterFragment extends Fragment {
    public static final String TAG = "RegisterFragment.TAG";

    //FACTORY METHODS
    public static RegisterFragment newInstance(){
        RegisterFragment frag = new RegisterFragment();
        return frag;
    }
    public RegisterFragment(){
        super();
    }
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.register_fragment,container,false);
        return view;
    }



}
