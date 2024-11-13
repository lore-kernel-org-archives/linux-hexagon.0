Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D403D201027;
	Wed, 13 Nov 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731517425; cv=fail; b=DtPAhDgeCyZV//mjYjnZsYJkAZ/UHNqnfneMzyy+D6zaTq7NMhbmqzqblHYLdBeUrZTaDmzyrzOVEknHLmfXRqRzzMaNfhsqgvAayPfgPCP3oPJTsWV2pvz3pDjnFJDl0yo8apfLbQIm+u/RSy9/THc5EDKkl1wF1IfE1KCfRWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731517425; c=relaxed/simple;
	bh=UnXPOEP4wWa5W7Q60969DYevhjlVB/mVNSqbDxGLNfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NCJFToUzPH4Xr0l9AlheoprJ4lBDGaVfhyKKeGHP8KFYcOTq+rl0H8gtJHAcMf16uI84HZvCGb13jaCrw4RjRppEbBE9Xt3lRLNYV84OaBSiWg0HnfDjS4QGxtNIuuDn0+ixdR+OeuuhrWDWV6A9Usy6/98/ct8JsxOdG1TvgCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cE+hicZX; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cE+hicZX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH1QKH015394;
	Wed, 13 Nov 2024 17:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UnXPOEP4wWa5W7Q60969DYevhjlVB/mVNSqbDxGLNfM=; b=cE+hicZXs+VW0sYc
	BH98XQs5HaNPdGuxhukvGk8XTLBqMwp5+oP7O37pQnfpjhBCzEobErWW6OT2IAwO
	XnrhWO789Ttxwxr/k13UMVYqd3FetwQhSpeKgik1nnDIcU8pFehN+jFjF3GXcotE
	P6b7zeFPaDplVQnpOlpaRfCa3XBIIyBGHJoHedC+UqGnc/U53o7a5+AbZ4lKeLzt
	2e/3vCaMJB7LFzhlIlEbkjufWwz6pRpp4oGYxmUncqZnFlbERMiSl4ynn814lr0f
	fdRF7rCgTa1HJnhwFbAnaSteUaJyg3yi+h1RfhW7DRPiypynXCNETfVNay7OGPjW
	SlghCg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vsf316km-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 17:03:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0Ts8wBJZ/1WzkxKbZdtwAVS+hnNu/rXEPDowi/dYNseEpUAD2e2XHxIy5K+h07i4LurdrZOt7IMaGeJwqu3+QHPRfy+wOSVny3Zzc1hJUrBSbSuMy/rDS0M4kZ+/6kTy/pjnWSBQ3WJGyB+3F3HYOVNXJLefPlbEuMQ3i/6ZnlkROm7AHA+mHCL70I2ychubh4TzLQELIhKU+1rDRrjnJj9dwz3emkim5qxRzuafyoGAHmKBL2n17DjVgEQ2vDC63vrgyMjV9ZO6M3gSojcczxItALMHrfvagUBrreDleGS3U1xiYFqk61OAheunG05BBaAQ8N9B6zUebQYkIGeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnXPOEP4wWa5W7Q60969DYevhjlVB/mVNSqbDxGLNfM=;
 b=YRcBHXDSoSG5uNqYElj9ALi4G17l8j/wnv1+xfJBcLpcNur2/VjSzy/LEA0GEanXHGCPYWLQki1YgK7hPaTX31yI4hIdcF1m1oCP1486w+ojsJHVwfkyDUlPI16j6kkb09j7WFwwTHWK0YHT0eNyjz3CAW0j23O4CHD38LkbD5oGoxYEqN0p2RSRulKAAFjIsnWjoj0qU4MyzGjhdF5A/DNvYi8CF8GLBFOaYnnTUPDuZggFPnyLgK7bp2Jp/dFOApFuE6dVa2Bjhovu3PgB1OmsX7Ogu6G0uuHGPawWGrNcqDhEMORt5BeCCV9jFXK87bejk0aBLBlc01FQ9dDPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DS0PR02MB10250.namprd02.prod.outlook.com (2603:10b6:8:192::5)
 by IA0PR02MB9855.namprd02.prod.outlook.com (2603:10b6:208:491::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Wed, 13 Nov
 2024 17:03:35 +0000
Received: from DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea]) by DS0PR02MB10250.namprd02.prod.outlook.com
 ([fe80::3df9:2304:93de:72ea%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 17:03:34 +0000
From: Brian Cain <bcain@quicinc.com>
To: Nick Desaulniers <ndesaulniers@google.com>
CC: Nathan Chancellor <nathan@kernel.org>,
        "linux-hexagon@vger.kernel.org"
	<linux-hexagon@vger.kernel.org>,
        "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>,
        Alexey Karyakin <akaryaki@quicinc.com>,
        Sid Manning
	<sidneym@quicinc.com>,
        Sundeep Kushwaha <sundeepk@quicinc.com>,
        Shankar
 Kalpathi Easwaran <seaswara@quicinc.com>
Subject: RE: allmodconfig link failure on -next (relocation R_HEX_B22_PCREL
 out of range)
Thread-Topic: allmodconfig link failure on -next (relocation R_HEX_B22_PCREL
 out of range)
Thread-Index: AQHbNYJkEqqIKaFdX0eC3yeaL8Dbd7K1QEgggAArBICAAAMGMA==
Date: Wed, 13 Nov 2024 17:03:34 +0000
Message-ID:
 <DS0PR02MB10250F1FAAA7F64208FA1EF4BB85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
References: <20241113041319.GA158543@thelio-3990X>
 <DS0PR02MB1025072B87B225A4A8F0953F5B85A2@DS0PR02MB10250.namprd02.prod.outlook.com>
 <CAKwvOdnWZZ9We85caDM7zQsrUeKhJ2v2xL8tJbjeVUEgv_vL9g@mail.gmail.com>
In-Reply-To:
 <CAKwvOdnWZZ9We85caDM7zQsrUeKhJ2v2xL8tJbjeVUEgv_vL9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB10250:EE_|IA0PR02MB9855:EE_
x-ms-office365-filtering-correlation-id: bde7694b-d73c-437a-f913-08dd04051bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWNqWTlBdTNQNFZWODJQRGUyV2c0ZFVMNXd6ZTMzNFVYd2x2WnRsdG9jYXlY?=
 =?utf-8?B?SGNHRW5pNDVycTFzSlBoL1E4QStud0RLdmpwKzlsVU1kUzdXNEM3SzZ4aFB2?=
 =?utf-8?B?OU4zOFhWeXlON2pTMmhodEVrYlZCZWZaaS9uSjlNSnhRT0xzUzNtQmhIOEpj?=
 =?utf-8?B?QzdhdVhNZXdqaGFWNDlYVFdESUl5VjgxNmZDSkZXK0duRENseDAzcGFuQkV6?=
 =?utf-8?B?NWdrWVY0Y1BoTnhNZEZIL1VvbU4yZFdjaCt1TjFQQTFPZmVjTEczVUJMSGls?=
 =?utf-8?B?Q0w4TmxsNnlKNzNMN1djdUQ3ZHdWY1B5cm9zMkRBdVNrNVh0d0VkZHh1Tzc5?=
 =?utf-8?B?bG0vZ3UxbDByOXBKcTREYXpjQTV3R2VxeG9zZDhuR2F1ckYyUzY1V09hNzgr?=
 =?utf-8?B?cEFURWJyQWRVVmVEV3JvM3c1MCtJRFZ5WHBTdENxZzlTN0pyRUJnb2t4UGNi?=
 =?utf-8?B?bXFBdGgzYWxpd2FJLzkzU3p0UUdaYlp3RDU1NkYvR0JwUWRpdGJVNy9zQ2U5?=
 =?utf-8?B?SURYR0xVbmFQWlkzdDg3dHFjVStRMlFRa2x3TnhlQUlXWEFZVWhMcU5NY2NT?=
 =?utf-8?B?ejdtV1BHYXVaenFMcEdUMEtWaHFIcjl6b29qUFZMWGlacjJiSDNMVHJKRDZy?=
 =?utf-8?B?YUhuazlKUG9sK3ZndTI3MFNGamdyeGJHbVVUUlVsYXU3YzhKd2xvVnBXR1dY?=
 =?utf-8?B?ZkM3MEZPTVBVeTU2V1QyS3o5ZFBHUGdSWmo5aWtEQ2djVXBPTkdUZmx4bm94?=
 =?utf-8?B?WTdPWUNyc2cycThKQnpsTlVaTTRhYXd5Ny9XSjZMM2NFMXpHWTJoTmtwRlBu?=
 =?utf-8?B?M3JXaU1MSUQrZmNVUlQrVTZDc1hsdHU1V0NIVU1IQ0t2TlZQTkFNa1ZHanc1?=
 =?utf-8?B?b0NaZEduTnVnZ25WYkdqMy9RdXdiV29uQnpzOWZMR1AxL1hvYjd0QTRPWWoz?=
 =?utf-8?B?d3czRVhyejFWaXJ1NmgzMDJpd3NVMU05OTdRaERkSEJGc2MyRERsajYxVU5H?=
 =?utf-8?B?dkNGT01iNGM4eEllRkhTSVZmb1pKSjFTZTJBRWhXRUNPeEJQSmpqbmtXc1Fj?=
 =?utf-8?B?bDBrNVFLRDRnaUc1QWNwOFp1WHlTTmxPVm42RytlRVZDcHFQTSt2L3o0OExC?=
 =?utf-8?B?NDlwOFJpTVJSdzhyZEZidVMyRUZhUmFiZERiSVN5SEF1WTc0K2IweStuMTR5?=
 =?utf-8?B?cVo5NU94S2gyNnd3dE4vTEMvNXhhMlJUQjI1RGhHZEYyR1gvUERhWDNRanZz?=
 =?utf-8?B?d0FzMFBNbFRRUm51TDAzazJiTjZvQlIrOEhQNEtWN3hmWk5sU1pIUllSQmZa?=
 =?utf-8?B?QTdaMUNpWDE1SkE4K0dKQ1VOV1dPL2c0NVFJRmd4ekJ4QXpBV0YrV0RYc2tR?=
 =?utf-8?B?eXhMZUQxdkxOdFVUdFZDNSsvQnhLYW9hSUpuRGpXOHpoSHMwODVWQWQwb1Ew?=
 =?utf-8?B?bnhrQkgvaGp1d0VGQ3hBd3ozRk5lQ29pQmZheFZ0R0tuNmJOZWFPcjJlVnA5?=
 =?utf-8?B?QThpS2d0TlhmMGZEb0VST0MxSmx3QWY2V2h1SUlWbzR5bmVySEpTRDcxaEhr?=
 =?utf-8?B?bWI1MjZYU3lYaTNrRm9BK3N2YW9vWXRZZ1VLRjV6YmFhTUMzdVNwZ3JWRnJ2?=
 =?utf-8?B?SDhIc3A5L0JOM21hWlRZUTRsMXFzL0FqNVBEZDRnQ2tRZVhEOXo2QXpTM3B2?=
 =?utf-8?B?a3VnN2ZNOXBOS1lzaUZpMjBOek0zNDBROWo2ZXcxQ09SZHlaRGpxaVpVT3lr?=
 =?utf-8?B?V2FGeFFKQnM5WFBVS1JrQ0RpRWtubGU3bm82bmxQMVJjU1NDKzRBZFFDV2dM?=
 =?utf-8?B?M3RIb2JNejJOei9OV3VoTzFUQjBrdmt0ZldnUWFSVzF0SHd5NkcwR3Qzbmpr?=
 =?utf-8?Q?skdjjLizvDmfD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB10250.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dWdDSVpmTEVPUlk1MWpLWWk2WEpQLzdVUGJzUUNrTXR6bVVMb0NlRmpsNGhi?=
 =?utf-8?B?K2NXdTBSbW4zeUZveTFISWtoRTNSOVhaU3pxMHVOWm8vMy9wbDBYT0dPTm5r?=
 =?utf-8?B?aEc4Z2RFTjJSSWhmdGdDS0g2VG9laWhDK21tNU02aUlWYUMvK1g4dkJwUUVz?=
 =?utf-8?B?SU81UEVSYks1VTQrdC9HWGVtR1UvS2JDKzhEemp1eFhUQXloblhtc3JrbHht?=
 =?utf-8?B?aDljV2JaSFNzaGFxWkF3K2NnY0dkQ29BdnBpMms3aFlHNXBiUmhYSmt5ZTZG?=
 =?utf-8?B?UkVRNXIwRkZ6UC84NlBZOUNyWHNtNTJ6VGJ0VFN5RElyc3EyTmhoNmhBOWJ5?=
 =?utf-8?B?RjBROUtyQnVBbnVvWFdrM3lueHZzdTJlRHFDYmx5ZW5weEhzbWZaNUlZUzFR?=
 =?utf-8?B?THE3d3ZoeDlHZTUvcEkzKytlWUV6M2NoRk1GZXNvS0NEb0pLWUNXby9XQ0dt?=
 =?utf-8?B?cVVQdjdkZmU5SHFncHZNb2hKb1dCM3NlbkIwNm54b0NlNE04RFBlTFo5QXh0?=
 =?utf-8?B?KzM3WWNYTEF3STFqSllRK0NWS09BQ0VGYTJqVjhMTXdYaVI1aE1qWWR4VUVp?=
 =?utf-8?B?dmxHazhJVDl1L1lzTHdqVEtiVFlibFJSS1FiSVoyVC9pcFczNGppaktldEQ0?=
 =?utf-8?B?MVhZdUlOZHBnUVNrZG1OUnl2L2VHbzJZNWNFSUN3ZHIwK3BjMnFuL0hDRXht?=
 =?utf-8?B?RzhRWTZGOGxMMXVxTjg1WVErYnFIMDQvMTNpdHVucXNOeEtrdTJHMHNjaVNa?=
 =?utf-8?B?TDlvbjdzQlhmVS9CUzBJam1sRmVDUHNiK2N6UTk2K0JmdTVPUUc5KzBWNC9N?=
 =?utf-8?B?T3Q4cEpGZ1VYb3JKU2d0V1JFV0lRNWJIYStyYkJ1N1phYkVzRlc0S2FCb3dS?=
 =?utf-8?B?akxGTFRabnJNcUNuMFBwU2VYSndCc2RiU2laeHJ1dkpVVEF6emd2Vmd6RGFE?=
 =?utf-8?B?cHZ0RmFSeENaWlpOZ25NRTBMMWhCbkc5OUZQSFl3dUdFUHRNTTZyekhQL3Fi?=
 =?utf-8?B?Qk45VGUxY3pFVDllbHRZc29UbUk5WDhtVE9jU2hIbzFsNkVYWlp1aGdOZm4r?=
 =?utf-8?B?WDBUbkRBd1hoSk9zWmswMWF4LzFtQ3gxZ1VySzNha2x2ZUYrOHdVelBuZUU4?=
 =?utf-8?B?d3lpRjJxZ1IrK25TR1lOSlprUCtHMC9xZ0djaGlZZ01XbUJLOW4vakxCTUNV?=
 =?utf-8?B?TG1SZHV5Sk5VMzNXZWI3SjdTbFdDL1NJTkFWb0hjRGlTMkdEbFdaK20rZ05w?=
 =?utf-8?B?MjJzYVN1bHF4NG1TaFJOZUcrVDJ0TkxIcGs0KzdYK2F0Ym5EajVqS1ZwSElH?=
 =?utf-8?B?K2ZiaDBiTlFKYVpPelNNekhBQnorZnVScWZzdTR4Yzh4U1ZCcUpVbnNacEhL?=
 =?utf-8?B?c3F0am1TWTk0OWtITStDb2JvWnR6K1VhOXhKVVBqQ3g2QW1kaHd1ZEJtZDZN?=
 =?utf-8?B?enh6dUtQOVlVNmE1eWJxcXlIMXlKUWZFT1ZFZTlHTnMxU2tIc1Q2Q2RRUWpu?=
 =?utf-8?B?emxDOEVWanprbUNicC9wRzZhVThaZ0lMdm5CaUhIUVZzTjlvWXExWkxvNng3?=
 =?utf-8?B?eitaanh2c3RtVW11dDM1cTB0MEZjbzVjU21ORWFZcWZvOHorK2xGWHMyWjZM?=
 =?utf-8?B?elYvSTRUUHpPaGRId3l2QkVKMUV6c2ZRT3luZmppN3JWYjMyZHdMWlZHVjFn?=
 =?utf-8?B?TG1aSTExQy8yMTNGL0xpUGZyeUlQQVZsU3NIanVPRzRRQ29aRTRlSGExa2Za?=
 =?utf-8?B?T1VKbFVmNnRGaDQ0dTRlQzBKL1RRU0U3cnZ3OGZ4b1BtaEpEZEZDdHJ3WTJm?=
 =?utf-8?B?WktlM0NBcWZMVkxMR2ZhVVpwYVVDL2xXa2Z3WjJWb29hNy9UVVhXWVdBeUNP?=
 =?utf-8?B?cklkeFF2NUduVlBGYWZOWkF5TzVRelF6bEJnMXAzVlZOcHZLZ3NCeUlTUEVX?=
 =?utf-8?B?eERwTnhJZVlNT0haeWhwOVFiYnpyV3lGNE9LSnpWTlJqL3RFVWxpODBuSGx0?=
 =?utf-8?B?VkhIM3JQbjMyM1pBMzMyRzRWRThSeWZMUkJxRzN1RERGMmtodnZoNFgxSHJi?=
 =?utf-8?B?aDVNWWxlaDVwYkJLWUE2TCtPelNwU0prNUJGTFVwRVlWc3VzR25xYUhjZGUv?=
 =?utf-8?Q?x82w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	auSaYg7VwNlk0oJwJelEaThraSnKm4KVUPg2EDp/OUj8XCq9YJDeykIeS3LP2KOQ6DkD7bZGtH4bZedppFhTDXZyFQ4kD07srB98ZYFsOZIyTn/pSedRFqcstxfRFNDd+j1IOKLWyqBILjk0yB0cFcu8/uGMF90fmLr6UM6yQMDyhthJsb1Rj9FVtXhBXcA06XKtk7enaxFdiUhTeTJ0xmDah90SQ/MMTovadM9C4KuA7jnoCWbZBtI0IVFd44XtdqqyA914+IVI0aQZDHsX4AVeHNjljWW3dmwkr5aDppFbY7A0r97spREKY+OEH+Fs5Ef2sIeCCSk87Eh6yfSeNkckqk1mtIr/Vc/BE2NH03E/R2dCRdTU7vNJr1sBC+UtJxa/3qAXabrESvGLXDKGoaSD92uD1vcpi8RdvxlHXumQb6BsM6QL6uKR7Am6ZtmhcG2QybxLYgMGewOvDidicpJERgUgdm+RoXPG1+0FDFTZrfrN5iDunMftRL0z60AxBWXBhhQhFvKG8dv+SB0e9wdJFA9wlylbMhgBlmvZEeIK6uLNUzlcXLgBax1LFMhYODSZAO+XU7FXdmhK3aNQ+VboKgE+0l9Vm+cCDRBw5PV3kH2z6pblolHAesUf6jGr
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB10250.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde7694b-d73c-437a-f913-08dd04051bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 17:03:34.4463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tj0jEqakiVFVNCDc2glU8MQtGBRcJ7uK5vPJtgvlCDXSYkmbBdfGqqxNGf/QsdUbsEPTXQNL2z2v4krpJmLz9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9855
X-Proofpoint-ORIG-GUID: SIkW6D4-KO1yX51ZJuepfwTFp-vgLMUR
X-Proofpoint-GUID: SIkW6D4-KO1yX51ZJuepfwTFp-vgLMUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130142

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWNrIERlc2F1bG5pZXJzIDxu
ZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAxMywg
MjAyNCAxMDo0MyBBTQ0KPiBUbzogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IENj
OiBOYXRoYW4gQ2hhbmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+OyBsaW51eC1oZXhhZ29uQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGx2bUBsaXN0cy5saW51eC5kZXY7IEFsZXhleSBLYXJ5YWtpbiA8
YWthcnlha2lAcXVpY2luYy5jb20+OyBTaWQgTWFubmluZw0KPiA8c2lkbmV5bUBxdWljaW5jLmNv
bT47IFN1bmRlZXAgS3VzaHdhaGEgPHN1bmRlZXBrQHF1aWNpbmMuY29tPjsNCj4gU2hhbmthciBL
YWxwYXRoaSBFYXN3YXJhbiA8c2Vhc3dhcmFAcXVpY2luYy5jb20+DQo+IFN1YmplY3Q6IFJlOiBh
bGxtb2Rjb25maWcgbGluayBmYWlsdXJlIG9uIC1uZXh0IChyZWxvY2F0aW9uIFJfSEVYX0IyMl9Q
Q1JFTA0KPiBvdXQgb2YgcmFuZ2UpDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBhIGtub3duIFF1YWxjb21tIHZlbmRvci4gUGxlYXNlDQo+IGV4ZXJjaXNlIGNhdXRp
b24gd2l0aCBhbnkgdW5leHBlY3RlZCByZXF1ZXN0cywgbGlua3MsIG9yIGF0dGFjaG1lbnRzLg0K
PiANCj4gT24gV2VkLCBOb3YgMTMsIDIwMjQgYXQgNjoxOOKAr0FNIEJyaWFuIENhaW4gPGJjYWlu
QHF1aWNpbmMuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPiA+IEZyb206IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4NCj4g
PiA+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDEyLCAyMDI0IDEwOjEzIFBNDQo+ID4gPiBUbzog
QnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+ID4gPiBDYzogbGludXgtaGV4YWdvbkB2
Z2VyLmtlcm5lbC5vcmc7IGxsdm1AbGlzdHMubGludXguZGV2DQo+ID4gPiBTdWJqZWN0OiBhbGxt
b2Rjb25maWcgbGluayBmYWlsdXJlIG9uIC1uZXh0IChyZWxvY2F0aW9uIFJfSEVYX0IyMl9QQ1JF
TA0KPiBvdXQgb2YNCj4gPiA+IHJhbmdlKQ0KPiA+ID4NCj4gPiA+IEFzIGFuIGFzaWRlLCBkbyB5
b3UgZm9sa3Mgd29ya2luZyBvbiBIZXhhZ29uIGRvIGFueSBzb3J0IG9mIHZhbGlkYXRpb24NCj4g
PiA+IG9mIHRoZSBrZXJuZWwgYW5kIHRvb2xjaGFpbj8gSSBmZWVsIGxpa2UgSSBoYXZlIHJ1biBp
bnRvIGEgZGVjZW50IG51bWJlcg0KPiA+ID4gb2YgSGV4YWdvbi1zcGVjaWZpYyBpc3N1ZXMgdGhp
cyB5ZWFyIGFuZCBJIGFtIGN1cmlvdXMgaWYgYW55IG9mIHRoZXNlDQo+ID4gPiB0aGluZ3MgaGF2
ZSBiZWVuIGNhdWdodCBieSBhbnkgdGVzdGluZyB0aGF0IHlvdSBtaWdodCBiZSBkb2luZy4NCj4g
Pg0KPiA+IFdlIGRvbid0IGRvIGVub3VnaCB0ZXN0aW5nIG9mIHRoZSB0b29sY2hhaW4gY2hhbmdl
cyB3aXRoIHJlZ2FyZCB0byB0aGUNCj4ga2VybmVsLiAgSSB0aGluayB3ZSBoYXZlIHJvb20gdG8g
aW1wcm92ZSB0aGVyZS4gIEknZCBsaWtlIHRvIGluY29ycG9yYXRlIG1vcmUNCj4gdGVzdGluZyBp
bnRvIG91ciB3b3JrZmxvdyBmb3IgbGFuZGluZyBjaGFuZ2VzIGluIHVwc3RyZWFtIExMVk0uDQo+
ID4NCj4gDQo+IEJ1aWxkIHRlc3RpbmcgYSBmZXcgImJsZXNzZWQgY29uZmlncyIgd291bGQgYmUg
YSBnb29kIHBsYWNlIHRvIHN0YXJ0Lg0KDQpZZWFoIC0gSSdkIGxpa2UgdG8gYWRkIHNvbWUgYnVp
bGRib3Qgb3Igc29tZSBvdGhlciBpbmZyYXN0cnVjdHVyZSB0aGF0IHdvdWxkIGhlbHAgZGV2ZWxv
cGVycyBmaW5kIHRoZXNlIGlzc3VlcyBzb29uZXIsIGluY2x1ZGluZyBrZXJuZWwgYW5kL29yIGJ1
aWxkcm9vdCBhbmQvb3IgbGx2bS10ZXN0LXN1aXRlLiAgSSdsbCBkaXNjdXNzIHdpdGggdGhlIHRl
YW0gaG93IHdlIGNvdWxkIGFjY29tcGxpc2ggdGhpcy4NCg0KPiBXZSBzcG9rZSBicmllZmx5IGEg
ZmV3IHdlZWtzIGFnbyBhYm91dCB1cHN0cmVhbWluZyBxZW11IHN5c3RlbQ0KPiBzdXBwb3J0OyB0
aGF0IHdvdWxkIGFsbG93IHVzIHRvIHN0YXJ0IGJvb3QgdGVzdGluZyAodGhvdWdoLCB3ZSdyZQ0K
DQpVc2luZyBxZW11IHN5c3RlbSBpcyB+bW9udGhzIGF3YXksIHVuZm9ydHVuYXRlbHkuICBCdXQg
dmVyeSBoaWdoIHByaW9yaXR5IGZvciB1cyBhbmQgaW4gcHJvZ3Jlc3MgcmlnaHQgbm93LiAgQSBi
aWcgZGVwZW5kZW5jeSBpcyBhIHdvcmtpbmcgaHlwZXJ2aXNvciBhbmQgdGhhdCBhY3Rpdml0eSBp
cyBvbmdvaW5nIGluIGh0dHBzOi8vZ2l0aHViLmNvbS9xdWljL2hleGFnb25NVk0NCg0KPiB1c2lu
ZyBidWlsZHJvb3QgdG8gY3JlYXRlIHNtYWxsIHVzZXJzcGFjZSBpbWFnZXM7IHdlJ2QgcHJvYmFi
bHkgbmVlZA0KPiB0byBsb29rIGludG8gaGV4YWdvbiBzdXBwb3J0IGluIGJ1aWxkcm9vdCB0aGVu
LCB0b28pLiAgV2UncmUgaGFwcHkgdG8NCg0KR29vZCBuZXdzISAgSXQncyB1bmRlcndheSB0b286
DQoNCmh0dHBzOi8vbGlzdHMuYnVpbGRyb290Lm9yZy9waXBlcm1haWwvYnVpbGRyb290LzIwMjQt
T2N0b2Jlci83NjU4ODIuaHRtbA0KaHR0cHM6Ly9naXRodWIuY29tL3F1aWMvYnVpbGRyb290L3Ry
ZWUvYmNhaW4vdG8tdXBzdHJlYW0NCg0KPiBob3Agb24gYSBjYWxsIHRvIGRpc2N1c3Mgc29tZSBv
ZiB0aGVzZSB0b3BpY3MgaWYgeW91IG9yIHRoZSB0ZWFtIGhhdmUNCj4gcXVlc3Rpb25zLg0KPiAN
Cj4gQWxzbywgdGhhbmtzIEFsZXhleSBmb3IgdGhlIHF1aWNrIGZpeCB0byBMTEQhDQoNCkl0J3Mg
YSBiaXQgb2YgYSBsdWNreSBjb2luY2lkZW5jZS4gIEkndmUgc2VlbiBvY2Nhc2lvbmFsICJvdXQg
b2YgcmFuZ2UiIGxpbmsgZXJyb3JzIHdpdGggdXNlciBwcm9ncmFtcyAodmlhIGJ1aWxkcm9vdCBl
dCBhbCksIHNvIEkgc3RhcnRlZCBkb3duIHRoZSBwYXRoIG9mIGFkZGluZyB0aHVua3MgdG8gbGxk
LiAgV2hpbGUgcmV2aWV3aW5nIHRoZSB0aHVuayBjaGFuZ2VzIHRvIGxsZCwgQWxleGV5IGZvdW5k
IHRoZSByZWxvY2F0aW9uIHNpemUgYnVnLiAgU28gaXQgd2FzIHVuZGVyd2F5IGJlZm9yZSB0aGlz
IHdhcyByZXBvcnRlZC4NCg0KLUJyaWFuDQo=
