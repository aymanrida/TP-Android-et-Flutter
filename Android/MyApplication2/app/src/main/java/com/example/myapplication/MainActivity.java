package com.example.myapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    private EditText editTextMontant;  private TextView textViewRes;  private Button buttonCalculer;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        editTextMontant=findViewById(R.id.editTextMontant);
        buttonCalculer=findViewById(R.id.buttonCalculer);
        textViewRes=findViewById(R.id.textViewRes);
        buttonCalculer.setOnClickListener(new View.OnClickListener(){

            @Override
            public void onClick(View v) {
                double mt=Double.parseDouble(editTextMontant.getText().toString());
                double res=mt*11;
                textViewRes.setText(String.valueOf(res));
            }
        });
    }
}
