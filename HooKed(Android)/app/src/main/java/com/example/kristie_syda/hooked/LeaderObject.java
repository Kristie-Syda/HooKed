package com.example.kristie_syda.hooked;

/**
 * Created by Kristie_Syda on 6/24/16.
 */
public class LeaderObject {
    private String mUsername;
    private int mRank;
    private int mScore;

    //Constructor
    public LeaderObject(String username, int rank, int score){
        mUsername = username;
        mRank = rank;
        mScore = score;
    }

    //Getters
    public String getmUsername() {
        return mUsername;
    }
    public int getmRank() {
        return mRank;
    }
    public int getmScore() {
        return mScore;
    }

}
