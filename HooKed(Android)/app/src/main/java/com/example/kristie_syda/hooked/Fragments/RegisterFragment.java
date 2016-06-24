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
import com.parse.SignUpCallback;

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

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);

        //TextFields
        final EditText first = (EditText) getView().findViewById(R.id.first);
        final EditText last = (EditText) getView().findViewById(R.id.last);
        final EditText email = (EditText) getView().findViewById(R.id.email);
        final EditText username = (EditText) getView().findViewById(R.id.username);
        final EditText password = (EditText) getView().findViewById(R.id.password);

        //Submit Button
        Button submit = (Button) getView().findViewById(R.id.btn_submit);
        submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if((username.getText().toString().matches("")| email.getText().toString().matches("")|password.getText().toString().matches(""))){
                    Toast.makeText(getActivity(), "Please fill in all fields", Toast.LENGTH_SHORT).show();
                } else {
                    //Create new parse user
                    ParseUser user = new ParseUser();
                    user.put("First",first.getText().toString());
                    user.put("Last", last.getText().toString());
                    user.setEmail(email.getText().toString());
                    user.setUsername(username.getText().toString());
                    user.setPassword(password.getText().toString());
                    user.signUpInBackground(new SignUpCallback() {
                        @Override
                        public void done(ParseException e) {
                            if (e == null) {
                                //No error
                                Intent intent = new Intent(getActivity(), MainActivity.class);
                                startActivity(intent);
                                Toast.makeText(getActivity(), "User Created", Toast.LENGTH_SHORT).show();
                            } else {
                                //Error
                                Toast.makeText(getActivity(), e.getMessage(), Toast.LENGTH_SHORT).show();
                            }
                        }
                    });
                }
            }
        });

        //Back Button
        Button back = (Button) getView().findViewById(R.id.btn_back);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().finish();
            }
        });

    }
}
