package com.example.kristie_syda.hooked.Fragments;

import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.example.kristie_syda.hooked.Activities.MainActivity;
import com.example.kristie_syda.hooked.R;
import com.parse.ParseException;
import com.parse.ParseUser;
import com.parse.RequestPasswordResetCallback;


/**
 * Created by Kristie_Syda on 6/22/16.
 */
public class ForgetFragment extends Fragment {
    public static final String TAG = "ForgetFragment.TAG";

    //FACTORY METHODS
    public static ForgetFragment newInstance(){
        ForgetFragment frag = new ForgetFragment();
        return frag;
    }
    public ForgetFragment(){
        super();
    }
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.forget_fragment,container,false);
        return view;
    }

    public static boolean isEmail(CharSequence target) {
        if (target == null) {
            return false;
        } else {
            return android.util.Patterns.EMAIL_ADDRESS.matcher(target).matches();
        }
    }
    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        final EditText email = (EditText) getView().findViewById(R.id.forget_email);
        Button btn_submit = (Button) getView().findViewById(R.id.btn_fSubmit);
        btn_submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(isEmail(email.getText().toString())){
                    ParseUser.requestPasswordResetInBackground(email.getText().toString(), new RequestPasswordResetCallback() {
                        @Override
                        public void done(ParseException e) {
                            if (e == null) {
                                // An email was successfully sent with reset instructions.
                                Toast.makeText(getActivity(), "Email Sent", Toast.LENGTH_SHORT).show();
                                Intent intent = new Intent(getActivity(),MainActivity.class);
                                startActivity(intent);
                            } else {
                                // Something went wrong. Look at the ParseException to see what's up.
                                Toast.makeText(getActivity(), "invalid email, try again", Toast.LENGTH_SHORT).show();
                            }
                        }
                    });
                } else {
                    Toast.makeText(getActivity(), "Please enter valid email", Toast.LENGTH_SHORT).show();
                }
            }
        });

        //Back button
        Button btn_back = (Button) getView().findViewById(R.id.btn_fBack);
        btn_back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().finish();
            }
        });

    }
}
