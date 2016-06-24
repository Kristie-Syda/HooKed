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
import android.widget.TextView;
import android.widget.Toast;

import com.example.kristie_syda.hooked.Activities.ForgotActivity;
import com.example.kristie_syda.hooked.Activities.MainActivity;
import com.example.kristie_syda.hooked.Activities.RegisterActivity;
import com.example.kristie_syda.hooked.R;
import com.parse.LogInCallback;
import com.parse.ParseException;
import com.parse.ParseUser;

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

        //Username & password text fields
        final EditText user = (EditText) getView().findViewById(R.id.login_username);
        final EditText pass = (EditText) getView().findViewById(R.id.login_password);

        //Forgot label & click listener
        TextView forgot = (TextView) getView().findViewById(R.id.forgotView);
        forgot.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent sIntent = new Intent(getActivity(),ForgotActivity.class);
                startActivity(sIntent);
            }
        });

        //Create account label & click listener
        TextView account = (TextView) getView().findViewById(R.id.createView);
        account.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent sIntent = new Intent(getActivity(),RegisterActivity.class);
                startActivity(sIntent);
            }
        });

        //Login Button
        Button btn_login = (Button) getView().findViewById(R.id.btn_login);
        btn_login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ParseUser.logInInBackground(user.getText().toString(), pass.getText().toString(), new LogInCallback() {
                    @Override
                    public void done(ParseUser user, ParseException e) {
                        if(user == null){
                            Toast.makeText(getActivity(), "Incorrect Username/Password", Toast.LENGTH_SHORT).show();
                            System.out.println(e);
                        } else {
                            Intent sIntent = new Intent(getActivity(),MainActivity.class);
                            startActivity(sIntent);
                            Toast.makeText(getActivity(), "Logging in...", Toast.LENGTH_SHORT).show();
                        }
                    }
                });
            }
        });

    }
}
