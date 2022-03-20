import React, { useEffect, useState }  from 'react';
import axios from 'axios';
import { useDispatch, useSelector } from 'react-redux';
import { View, Text, TextInput, Image, TouchableOpacity, StyleSheet } from 'react-native';
import {format} from 'date-fns';

import {updateUser, updateUserWallet} from '@redux/User';

import DatePicker from 'react-native-date-picker';

import SexSelectButton from '@components/common/SexSelectButton';

import CharacterMale from '@/assets/image/character-male.png';
import CharacterFeMale from '@/assets/image/character-female.png';

import Web3 from 'web3';

const RegisterView = ({callBack}) => {
    
    const [isOpen, setIsOpen] = useState(false);
    const [date, setDate] = useState(new Date());

    const [gender, setGender] = useState('female');
    const [height, setHeight] = useState(165);
    const [weight, setWeight] = useState(56.1);
    
    const userInfo = useSelector(({user}) => user.info);
    
    const dispatch = useDispatch();

    console.log(userInfo);

    useEffect(()=>{
        setGender(userInfo.gender);
    },[]);

    const handleRegister = async () => {

        const web3 = new Web3(new Web3.providers.HttpProvider('https://api.baobab.klaytn.net:8651/'));

        const account = web3.eth.accounts.create();

        const response = await axios.post('https://caloriecoin.herokuapp.com/api/user/registerUserAndWallet',{
            kakaoId: userInfo.id,
            profile: userInfo.profileURL,
            avartar: gender,
            gender: gender,
            nickname: userInfo.nickname,
            birthday: format(date, 'yyyy-MM-dd'),
            height: height,
            weight: weight,
            address: account.address,
            balance: '0',
            privateKey: account.privateKey
        });

        dispatch(updateUserWallet({
            address:account.address,
            privateKey:account.privateKey
        }));

        dispatch(updateUser({
            id: userInfo.id,
            nickname: userInfo.nickname,
            profileURL: userInfo.profileURL,
            gender: gender,
            birthday: format(date, 'yyyy-MM-dd')
        }));
      
        if(response) callBack(true);
    };

    return <View style={styles.container}>
        <Text style={styles.logo}>CalorieCoin</Text>
        <Text style={{fontFamily:'SUIT-SemiBold', fontSize:16}}>Please enter basic information</Text>
        <Text style={{fontFamily:'SUIT-SemiBold', fontSize:16}}>for accurate body data analysis.</Text>
        <Image source={gender === 'male' ? CharacterMale : CharacterFeMale} style={{width:84, height:142, margin:8}}/>
        <SexSelectButton gender={gender} onChangeHandler={(sex)=>{
            setGender(sex);
        }}/>
        <Text style={{fontFamily:'SUIT-SemiBold', fontSize:24}}>{userInfo.nickname}</Text>
        <TouchableOpacity onPress={()=>{setIsOpen(true);}} style={styles.inputContainerBirth}>
            <Text style={styles.inputTitleBirth}>Date of Birth</Text>
            <Text style={styles.inputBox}>{format(date,'yyyy/MM/dd')}</Text>
        </TouchableOpacity>
        <View style={styles.inputContainer}>
            <Text style={styles.inputTitle}>Height</Text>
            <View style={{width:'100%',flexDirection:'row', justifyContent:'center', alignItems:'center'}}>
                <TextInput
                    style={styles.inputBox}
                    onChangeText={setHeight}
                    value={height}
                    keyboardType='numeric'
                    placeholder='165'
                />
                <Text style={styles.inputBox}>cm</Text>
            </View>
        </View>
        <View style={styles.inputContainer}>
            <Text style={styles.inputTitle}>Weight</Text>
            <View style={{width:'100%',flexDirection:'row', justifyContent:'center', alignItems:'center'}}>
                <TextInput
                    style={styles.inputBox}
                    onChangeText={setWeight}
                    value={weight}
                    keyboardType='numeric'
                    placeholder='60'
                />
                <Text style={styles.inputBox}>kg</Text>
            </View>
        </View>
        <TouchableOpacity onPress={()=>{handleRegister();}} style={styles.saveButton}>
            <Text style={{fontFamily:'SUIT-SemiBold', color:'white'}}>Save</Text>
        </TouchableOpacity>
        <DatePicker
            modal
            mode='date'
            open={isOpen}
            date={date}
            onConfirm={(date) => {
                setIsOpen(false);
                setDate(date);
            }}
            onCancel={() => {
                setIsOpen(false);
            }}
        />
    </View>;
}

const styles = StyleSheet.create({
    container:{
        flex:1, 
        backgroundColor:'#fff',
        justifyContent:'center', 
        alignItems:'center'
    },
    logo:{
        fontFamily: 'Kanit-ExtraBoldItalic',
        color:'#FF3348',
        padding:14,
        fontSize:28,
    },
    inputContainer:{
        marginTop:18,
        backgroundColor:'#f1f1f5',
        width: '85%',
        padding:42,
        paddingTop:0,
        paddingBottom:0,
        borderRadius:16,
        justifyContent:'center',
        alignItems:'center'
    },
    inputContainerBirth:{
        marginTop:18,
        backgroundColor:'#f1f1f5',
        width: '85%',
        padding:42,
        paddingTop:14,
        paddingBottom:14,
        borderRadius:16,
        justifyContent:'center',
        alignItems:'center'
    },
    inputTitleBirth:{
        fontFamily:'SUIT-Regular',
        fontSize:14,
        color:'#9ea4a9',
        marginBottom:8,
    },
    inputTitle:{
        fontFamily:'SUIT-Regular',
        fontSize:14,
        color:'#9ea4a9',
        marginTop:10,
    },
    inputBox:{
        fontFamily:'SUIT-ExtraBold',
        fontSize:28,
        color: '#171725',
    },
    saveButton:{
        marginTop:24,
        marginBottom:24,
        backgroundColor:'#ff3348',
        padding:50,
        paddingTop:12,
        paddingBottom:12,
        borderRadius:10,
    }
});

export default RegisterView;