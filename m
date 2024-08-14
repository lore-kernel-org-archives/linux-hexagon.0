Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F93A28D;
	Wed, 14 Aug 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723653074; cv=fail; b=t5QjwAQhGe0Ff5tt/Bsuwls7T2wLG2fSgFbYxP2Uh5JGZaKEM6SOTAeGYn1K4hZWRiFRvRe37K0iYaqF1vngaxjiTLcSBG9WqFZY8NxzsOTDggJX3quVu2YH4ceAEjEXwZgrzZlbVsYw0Sqj/21Eg1F0H5YSXByUrWF2oiKinJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723653074; c=relaxed/simple;
	bh=HBeyKTQhXL99bzgXxNkfx6cMspwVCkR7hMZ0YfO/Y+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ugF5/RDqYAljtlMIOhum1oCZPBMmwympVDXlTHZrJqu+gTC4TZiGuTEaReKoad6VMAx8MrFnab5ofRRP8Ohs45KVc91X2tJA+sfYDLcBUUrhA2P/wjjnyV9hjk1Xu8d1jwyCMOBtgNvZRP74HeKOFTycOKLxnl7YiyWeeJAPjjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ff7/j9lV; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ff7/j9lV"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EAf3N9017641;
	Wed, 14 Aug 2024 16:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pwNtXv0dmr0WFvGGsqh+ZZLQ/tEAo1zCudJaxczcG9E=; b=Ff7/j9lVvbrOW6zO
	Gu+EvS5RBdd8G33fl2uHAnrIiDx1C9lBLTax4TCajhHXziyYdsKU7DYnePTqsGFa
	Xj1sQm9w8PYFSW3TENwZNQNF0wyhZ9UKLNY/c5g3pDsIt/wd6DhYI6ZPFpayS01h
	p4/XlkcjE8u3Dht4Tk3AMZ3WwBu2syjqISKQN0E/kIFjWO1WEje0wBRzNSzOpyKQ
	ZecsxA05IOgPkVFrThd9GIAjBny2cZW+eHJyof+YWbn687eDRRKhmWL4p8RS2Y8m
	l6mFHOxG31MXSQA33SRAMn3nNgITpOHxbRGO7aWHH2OkErJ5GY+SFqSWrqfMjupC
	8C3Zww==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012050.outbound.protection.outlook.com [40.93.14.50])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 410j1jac27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 16:30:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUSGZRD8toweID1lmBaZzkvT8MvTlIoytyfeXaNnQIksdHoAYdtGgN1UW7dlHhj7Z4bLw7wpctiWNzDFLuv/cvOSFy/oKx5x91Se4lXy7OReyWZxQMGa98VUJxJGHhhuilkeKrH2Rjyg7UXwbhpOWLgHdkO8mY7xaG6AHgAPTI/NyAPGqTf37IGD6NADpPWnRncFfML/tr45A4mvzoXJClZ+JB4F4rREvHaKogjA3amgoyWkHD9yOaBESZ2cQHjXhaUJ0aOrbk8CCK07nolH6HRZkc2Hy7FSxoe6jrZTFLG+xQl6O175wJXQAZm/srpZo7jWAqIQbwUYbiXketcqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwNtXv0dmr0WFvGGsqh+ZZLQ/tEAo1zCudJaxczcG9E=;
 b=JzI3KegtwA+F9EHyGXtwL7SAr4nUARfkw5TPGJmkaYX9/GCFIXESr9GYEf1RpMMW2UbVwGpUTIZqvpuBi5quXjdZuoIov4Tm8GQ9Mx8eYZ7HX5OOjWZ5u0s3mezhezzeFsfWnN+4UkYMCyKmadu9KBU3N4Y7NVpKyrQpD1+xM8sc/yUW62KZIDLS4YQKsnHo5SX9qUR9KgweQlmilDS+glXBsx/xPsr2CrUpX+He/hpCxzxPQBkod19P7p4lKUyNHiENpcyOK6EJNvjX2j3sUgf7d1P3w0QNMadgabsUkZbRSsvZRWkVCRqwG/RlAZkcC1oukttLQ9UbiWbLBZzkyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BL0PR02MB3860.namprd02.prod.outlook.com (2603:10b6:207:49::22)
 by IA0PR02MB9808.namprd02.prod.outlook.com (2603:10b6:208:490::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 16:30:51 +0000
Received: from BL0PR02MB3860.namprd02.prod.outlook.com
 ([fe80::950e:fbde:f9bb:ca47]) by BL0PR02MB3860.namprd02.prod.outlook.com
 ([fe80::950e:fbde:f9bb:ca47%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 16:30:51 +0000
From: Steven Walk <walk@qti.qualcomm.com>
To: Brian Cain <bcain@quicinc.com>, Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Steven Walk (QUIC)"
	<quic_walk@quicinc.com>
CC: kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva"
	<gustavoars@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        LKML
	<linux-kernel@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org"
	<linux-hexagon@vger.kernel.org>,
        Sid Manning <sidneym@quicinc.com>,
        Sundeep
 Kushwaha <sundeepk@quicinc.com>
Subject: RE: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct memb...
Thread-Topic: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
 include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
 requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) ==
 sizeof(struct uverbs_attr_bundle_hdr)': struct memb...
Thread-Index: AQHa5GAx8pxBq9usEUCI4KlonF1oTLIS/ZyAgAGN1ACABdgR0IALxJwggADXmZA=
Date: Wed, 14 Aug 2024 16:30:51 +0000
Message-ID:
 <BL0PR02MB38609B668C6A96465AC9F028E3872@BL0PR02MB3860.namprd02.prod.outlook.com>
References: <202408011956.wscyBwq6-lkp@intel.com>
 <138da3e5-0e24-41a6-bb35-df5d07045eb3@embeddedor.com>
 <20240801190813.GC122261@thelio-3990X>
 <f40160aa-7cbd-4264-be44-45396b09574f@embeddedor.com>
 <20240801221427.GA3773553@thelio-3990X>
 <ca056227-30c3-47b9-a19a-fbab87778f20@embeddedor.com>
 <20240802221952.GA737452@thelio-3990X>
 <CH3PR02MB10247E2B6524ACA52F747A0C0B8BF2@CH3PR02MB10247.namprd02.prod.outlook.com>
 <CH3PR02MB102474F1D633D03102B5F2855B8872@CH3PR02MB10247.namprd02.prod.outlook.com>
In-Reply-To:
 <CH3PR02MB102474F1D633D03102B5F2855B8872@CH3PR02MB10247.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB3860:EE_|IA0PR02MB9808:EE_
x-ms-office365-filtering-correlation-id: 40045c62-af7b-42af-485b-08dcbc7e765f
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?cMwtQg2dXS2xDU1YTAkdqMBvKZXGP0vybSNCeF6HECgDr1g3DBhx/vLB44tC?=
 =?us-ascii?Q?Jrbf2ELiVDzHU5Tuzbw4tjFY+kDXEHt3U8wsr0+hEkfF0GXO9Qqmo7fSxtUG?=
 =?us-ascii?Q?6N5tuVXStvDykWYtzNlia8Lseyv2WdelpN3/arTwfh1LnIt8wy+ntOaIpO9k?=
 =?us-ascii?Q?ydNqVhGsTtVijdwTazcbwJ2KzR35Jxqlek18ojfP2mUS0273rxjjkJq1oraz?=
 =?us-ascii?Q?gofDtkIHkb6FAx1IZSZXJ7eKyAr34DhEA3mjNZV4ziBFOqbs70HgMHjJ/5PR?=
 =?us-ascii?Q?V71kKzsKtj4a+uidFVZ3tS1J4iPcSNy20zzYKt8yVbVj5kzVEuEIvf/ApuaD?=
 =?us-ascii?Q?dSdVZJUvk1ZmudFhQ7Yqhh4IvdmLymkQz/to3QsOMXQyjOzbaKNHh5p0WP6b?=
 =?us-ascii?Q?dWM5LaH6Yjn6rQUVcp3takQ0L6v11mMJZS8PwZW834leqPkMQGmWY6geuIbe?=
 =?us-ascii?Q?CVpxflDkOftymMncUONfennHHUd9RozCM5WWnBm69LxY14pdrl8BVIcT94YO?=
 =?us-ascii?Q?42AIa8/Ok5IpCWgRzT0Q9+F7R5UrlXV0A8PS0+puV8OD35SozOP2rYB6kdW1?=
 =?us-ascii?Q?SZDw+Blmzy9K8K9BGTe0aLcwqEroB8LxnYKdY+BagKs0oKFNiprMDcxbltEE?=
 =?us-ascii?Q?28jC6E3zE30o5Yizg+fwjCcHNTv+o7Gqnc+lBDfC4yhyOeJGHo7pzrpE6jeI?=
 =?us-ascii?Q?5D3COZTn+bLeyz+7DDo3qeWgK4jpERLQRgX8MADPCH3zeWFd/gDQlLp5RADP?=
 =?us-ascii?Q?J6EqEG3meHKzWSk8x8l04ltgOZ2P9hvuP/kKuKMCGiN2euXXuBdwZgtrrKgI?=
 =?us-ascii?Q?euL9GyFx0IzTLiRkh4xG2pxkuqKVWdasGv8+14TTq3yY9I4zt6GTRgCkLsXK?=
 =?us-ascii?Q?nO0gurMWLRSDMzGW3LS/6WpeBlTOTLUHvImPxRkX06bouhxZ/Lhx3+jvSABf?=
 =?us-ascii?Q?ZCVkuyGZSOCpxND4vNSJGbmoXH/F4gz34pZNm0/lNkdCiCCApN/UXuDet+Bw?=
 =?us-ascii?Q?2+pExDrNPuaJeh9c/jbMSjkJA8qBKQiN1R53v6UJGI82/5LIwQ9A0vIr7yid?=
 =?us-ascii?Q?5mO7bVJ0mi1ZoaLbsC3U0PlL9qLyUFX70goRzhV937jQe0kYmBlM9XQXPQba?=
 =?us-ascii?Q?l/WK0igndEY06BDTzTjct0OLEK0nrmN9y/zuAog9sbZZAGHXNlqMeWjK1PkM?=
 =?us-ascii?Q?dhePt0xNIj6B4t2ivk4InMSNMVq55WZKjL42r/4LVNABPVINZ4gh8cU+T2Qi?=
 =?us-ascii?Q?2awTmq4zzyXfe9HxnX/oTvid7sLyNTkHhoXAZs2nwAMAO9Sq+kGRlEJxqahC?=
 =?us-ascii?Q?6ROLTkuWaE2IJBL8H80dukp4udUlx1KP97RCUwwP/joYHdv+lb2bcuA4xEl+?=
 =?us-ascii?Q?SvLsPgo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB3860.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1ieNh9v+p25jCAWHFu9sHzJ5qYihMAJV1tD+8KHQFeOFDvz8j7B6E2Umf902?=
 =?us-ascii?Q?qG8xL9HJo24hdSnc9DRxwzc4X1Ztt+C6vhTd1Mqj+zmC0OpKPZZ7zTO4bdqt?=
 =?us-ascii?Q?8Qu9FnnnneHSIVmA7DoEYl+NCpUjmg9ihYRTkmjzm7OEO9BU6foZo51e1vuA?=
 =?us-ascii?Q?b8V/yEs43/4gqaLGeg1Onc3lCJ88szRnJFjJoiwvCpid8vyPacecfDUAfmmo?=
 =?us-ascii?Q?PICkzm/yqxA0WSc6EHPZT8+mCZBUrevL7QKydxPMoA/1eNvZb9AxY7GDSG51?=
 =?us-ascii?Q?Q1QOAFHOW5vAMHfsdemXQYa0nadoXNlRdSx4bOWb7QjQA6q95R9JiqVKR1Kg?=
 =?us-ascii?Q?bE2XDeBlSOMbNVnoYSHrLuFribF/iUDRUzdWQ3Bzur018RoFt9o4tEmBfwZu?=
 =?us-ascii?Q?Kk8QjVdgwTZ6lwVJDNmLak/F1aq320bglScPGKMxH+6lkUkAdqTO1ifNjPMq?=
 =?us-ascii?Q?92m6PqpDBY28/Doiy7rORijju4G5Xq5k/lgkDtPYB2FKQewF69sex/vcC6Ek?=
 =?us-ascii?Q?IlboBTpOWe3PS/eS9dMt/Lae9hzP4bCvjKOp6EPjsN9T53QTMfPTC+oYy+7L?=
 =?us-ascii?Q?U926J4DeaBDY56IVD9NU6zpgrgt1sh8C1LMkCwHZe56noUcMnP4bNFL7qMlM?=
 =?us-ascii?Q?FOZehAizDp9AJuKcoYa0jfKJDiHb7Tu7h90Uc00UknpTQtm3qGnx0jbkpuWr?=
 =?us-ascii?Q?xDsDRbKr3El0viAHlz4cGzZB6I4ghUZPw9gAZuQ5WyiLpN8aVoFzvwNuH/dr?=
 =?us-ascii?Q?PcyWqOZd6B2gxfmln+jsmaOzHCdNFoMDBEdn3cXtRAENJqjquopuCBnVtrhP?=
 =?us-ascii?Q?rwxfmTTqow+n+I1VTTAEDmMKGTmywfJvLVrFDVmsf4/z4AsmAn8kF6Myzv8F?=
 =?us-ascii?Q?Yzx+8D/+BG/ob1l/MhnhO9aamEOBPcNiXSTDkmK6Ku+pSYwlCfsMWw7GQsEn?=
 =?us-ascii?Q?SBDWRw2B+r7RbXVTr9TXc0WKtzee+jqs/GP51DHng6SkqJ3q/uqx6zAwie1G?=
 =?us-ascii?Q?YHYxL+0sFJlT3AcOiJe7pQWrzBiapgLlrA4xPweEi414nP0h/xlygXBCq0d9?=
 =?us-ascii?Q?7AFwUAsoLrIXIW4KdVELCGddwUc8ch8m/jXb7IZJkKt7Q/R9HiGnhWURm06e?=
 =?us-ascii?Q?iTGh/gAv0CNpG0butRk/qaCHU7/2bjszvfhj6l9lhHRfOmqPq7mzuLQlKwnE?=
 =?us-ascii?Q?tItfYdmwxxbAeASZByL5juxxbvmjrv3r8zlaNYEMkT53Eec9dCaAUed45Ttk?=
 =?us-ascii?Q?0C0sM6puFFN1znxHM0M3KXeeA4Te/i7aj+EHHK0C5X759TIQvt7V9ZMZeISa?=
 =?us-ascii?Q?LlFOY4MCfCbCCoH95BONM8bqSP0SzQ6I8C5tFKuaocSyJWmoEBh92sU0/n/Y?=
 =?us-ascii?Q?zqptIhxpYvWLPtxGZ2ZFjwmV827ly5JJofjyLBwmVUsG3uvnOD5SjRwFk6Ip?=
 =?us-ascii?Q?DE0ET3pHTIFB1WVqEB8FqmZ7XMxysWaWQrTj19pcG7Gg9jdn6raDk2U5jsns?=
 =?us-ascii?Q?mqKDHf2wEh0znDX7tqztJDtQL9l6hi6ffMRZrujFX5iJgNKg7bnGQcVI0ru5?=
 =?us-ascii?Q?UHB/w1cgRPThpemPFzW3YoFLCRr6qADevhDaHwS+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yzBYExsCgXEAcpHas8Gc90aocCp9UUX+5Sne10L3XMndVg/Icqz95jJyt7M1F5EXG5uxeTHLjgFpHn41BfUcdoeL2qyqjUfWJOD3mxSw31EnsJpSxwGSxCBFufOa2ZY3mCOQoU7m9+P7r0rFyyaYdkwUis9CV9RVoOWqZ78wemVD9rz58XVZxg90MqVTpEuRGP6G9osaIEwyXP6pYFCp7xUysBXsj3dXInv7bJLiJTejKuzWlmqFlh9dRm9M7A8yKrRMAiVTov+nrxG8pn2nrZKntCHktL5GEqO67TIakZU39ccCV0gxU34JhSvAptIEDVzhl3x0kEJFAGUkzyGcn7gV6/yEDSta1ItwIpkrIHUfc79QvP6YoMP/nu7AFnJQubocc87DB6ozPEugL7xLXd/Jx1CJKVuN671DrsqckXSrK/pXhGYbyziS55aPK7sotRZM1CAhycY7tm5xcAmVbQPRbEUNWKhsl+RMFI8wqGU74j8IKu9eS38jy0gEzkXirpl8dlFvPuTrzgR23SxL2YL8/6psX9Bdv2n42msjnWaFuoBSLkpMu6Sz4TPxTNUBKZGpEhSdPGunxHX5bYbTELdJmb2EZtgUvYHhQup+Gph4PapcEGK+l7Qax8fNm8EF
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3860.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40045c62-af7b-42af-485b-08dcbc7e765f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 16:30:51.7011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jcDxQ06tj5o2h7T4ZtZsMjQiRGmQWGeEHMK/qtnu49BCULO2FB8v9bVPMidkhtGix3y72N2dzfnrnhhnai+zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9808
X-Proofpoint-ORIG-GUID: MFw53F7Uw4WhtcU7nsBQzR-GPV1HyaO_
X-Proofpoint-GUID: MFw53F7Uw4WhtcU7nsBQzR-GPV1HyaO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_12,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408140113

Hello Brian, et.al

This is not related to clang-20.

The compiler is asserting because the expression is not considering the ali=
gnment
of the 'attrs' member.  This can be seen in the output when -fdump-record-l=
ayouts=20
is added the compiler (and the assert commented out).  The union in=20
question is:

struct uverbs_attr_bundle {
   union { <union entries including uverbs_attr_bundle_hdr> }
   struct uverbs_attr attrs[];
};

Static_assert(
   __builtin_offsetof(struct uverbs_attr_bundle, attrs) =3D=3D sizeof(struc=
t uverbs_attr_bundle_hdr),=20
   "struct member likely outside of struct_group_tagged()")
note: expression evaluates to '56 =3D=3D 52'

Regards,

Steve Walk


Evidence below.

28127 *** Dumping AST Record Layout
28128          0 | struct uverbs_attr_bundle
28129          0 |   union uverbs_attr_bundle::(anonymous at noAssert.c:941=
78:2)
28130          0 |     struct uverbs_attr_bundle::(anonymous at noAssert.c:=
94178:10)
28131          0 |       struct ib_udata driver_udata
28132          0 |         const void * inbuf
28133          4 |         void * outbuf
28134          8 |         size_t inlen
28135         12 |         size_t outlen
28136         16 |       struct ib_udata ucore
28137         16 |         const void * inbuf
28138         20 |         void * outbuf
28139         24 |         size_t inlen
28140         28 |         size_t outlen
28141         32 |       struct ib_uverbs_file * ufile
28142         36 |       struct ib_ucontext * context
28143         40 |       struct ib_uobject * uobject
28144         44 |       unsigned long[2] attr_present
28145          0 |     struct uverbs_attr_bundle_hdr hdr=20
28146          0 |       struct ib_udata driver_udata
28147          0 |         const void * inbuf
28148          4 |         void * outbuf
28149          8 |         size_t inlen
28150         12 |         size_t outlen
28151         16 |       struct ib_udata ucore
28152         16 |         const void * inbuf
28153         20 |         void * outbuf
28154         24 |         size_t inlen
28155         28 |         size_t outlen
28156         32 |       struct ib_uverbs_file * ufile
28157         36 |       struct ib_ucontext * context
28158         40 |       struct ib_uobject * uobject
28159         44 |       unsigned long[2] attr_present
28160         56 |   struct uverbs_attr[] attrs //<<--- Field used in _Stat=
ic_assert
28161            | [sizeof=3D56, align=3D8]
28162

28022 *** Dumping AST Record Layout
28023          0 | union uverbs_attr::(anonymous at noAssert.c:94169:2)
28024          0 |   struct uverbs_ptr_attr ptr_attr
28025          0 |     union uverbs_ptr_attr::(anonymous at noAssert.c:9414=
9:2)
28026          0 |       void * ptr
28027          0 |       u64 data
28028          8 |     u16 len
28029         10 |     u16 uattr_idx
28030         12 |     u8 enum_id
28031          0 |   struct uverbs_obj_attr obj_attr
28032          0 |     struct ib_uobject * uobject
28033          4 |     const struct uverbs_api_attr * attr_elm
28034          0 |   struct uverbs_objs_arr_attr objs_arr_attr
28035          0 |     struct ib_uobject ** uobjects
28036          4 |     u16 len
28037            | [sizeof=3D16, align=3D8] //<<--- Required alignment
28038

This record is in the union that cries.

28093 *** Dumping AST Record Layout
28094          0 | union uverbs_attr_bundle::(anonymous at noAssert.c:94178=
:2)
28095          0 |   struct uverbs_attr_bundle::(anonymous at noAssert.c:94=
178:10)
28096          0 |     struct ib_udata driver_udata
28097          0 |       const void * inbuf
28098          4 |       void * outbuf
28099          8 |       size_t inlen
28100         12 |       size_t outlen
28101         16 |     struct ib_udata ucore
28102         16 |       const void * inbuf
28103         20 |       void * outbuf
28104         24 |       size_t inlen
28105         28 |       size_t outlen
28106         32 |     struct ib_uverbs_file * ufile
28107         36 |     struct ib_ucontext * context
28108         40 |     struct ib_uobject * uobject
28109         44 |     unsigned long[2] attr_present
28110          0 |   struct uverbs_attr_bundle_hdr hdr
28111          0 |     struct ib_udata driver_udata
28112          0 |       const void * inbuf
28113          4 |       void * outbuf
28114          8 |       size_t inlen
28115         12 |       size_t outlen
28116         16 |     struct ib_udata ucore
28117         16 |       const void * inbuf
28118         20 |       void * outbuf
28119         24 |       size_t inlen
28120         28 |       size_t outlen
28121         32 |     struct ib_uverbs_file * ufile
28122         36 |     struct ib_ucontext * context
28123         40 |     struct ib_uobject * uobject
28124         44 |     unsigned long[2] attr_present
28125            | [sizeof=3D52, align=3D4]
28126

-----Original Message-----
From: Brian Cain <bcain@quicinc.com>=20
Sent: Tuesday, August 13, 2024 10:27 PM
To: Brian Cain <bcain@quicinc.com>; Nathan Chancellor <nathan@kernel.org>; =
Gustavo A. R. Silva <gustavo@embeddedor.com>; Steven Walk (QUIC) <quic_walk=
@quicinc.com>
Cc: kernel test robot <lkp@intel.com>; Gustavo A. R. Silva <gustavoars@kern=
el.org>; llvm@lists.linux.dev; oe-kbuild-all@lists.linux.dev; LKML <linux-k=
ernel@vger.kernel.org>; linux-hexagon@vger.kernel.org; Sid Manning <sidneym=
@quicinc.com>; Sundeep Kushwaha <sundeepk@quicinc.com>
Subject: RE: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18] include/=
rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to requireme=
nt '__builtin_offsetof(struct uverbs_attr_bundle, attrs) =3D=3D sizeof(stru=
ct uverbs_attr_bundle_hdr)': struct memb...



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Tuesday, August 6, 2024 10:36 AM
> To: Nathan Chancellor <nathan@kernel.org>; Gustavo A. R. Silva=20
> <gustavo@embeddedor.com>
> Cc: kernel test robot <lkp@intel.com>; Gustavo A. R. Silva=20
> <gustavoars@kernel.org>; llvm@lists.linux.dev;=20
> oe-kbuild-all@lists.linux.dev; LKML <linux-kernel@vger.kernel.org>;=20
> linux-hexagon@vger.kernel.org; Sid Manning <sidneym@quicinc.com>;=20
> Sundeep Kushwaha <sundeepk@quicinc.com>
> Subject: RE: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
> include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due=20
> to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs)=20
> =3D=3D sizeof(struct uverbs_attr_bundle_hdr)': struct memb...
>=20
> WARNING: This email originated from outside of Qualcomm. Please be=20
> wary of any links or attachments, and do not enable macros.
>=20
> > -----Original Message-----
> > From: Nathan Chancellor <nathan@kernel.org>
> > Sent: Friday, August 2, 2024 5:20 PM
> > To: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > Cc: kernel test robot <lkp@intel.com>; Gustavo A. R. Silva=20
> > <gustavoars@kernel.org>; llvm@lists.linux.dev;=20
> > oe-kbuild-all@lists.linux.dev; LKML <linux-kernel@vger.kernel.org>;=20
> > Brian Cain <bcain@quicinc.com>; linux- hexagon@vger.kernel.org
> > Subject: Re: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
> > include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed=20
> > due to requirement '__builtin_offsetof(struct uverbs_attr_bundle,=20
> > attrs) =3D=3D sizeof(struct uverbs_attr_bundle_hdr)': struct memb...
> >
> > WARNING: This email originated from outside of Qualcomm. Please be=20
> > wary
> of
> > any links or attachments, and do not enable macros.
> >
> > On Thu, Aug 01, 2024 at 04:35:59PM -0600, Gustavo A. R. Silva wrote:
> > >
> > >
> > > On 01/08/24 16:14, Nathan Chancellor wrote:
> > > > On Thu, Aug 01, 2024 at 02:17:50PM -0600, Gustavo A. R. Silva wrote=
:
> > > > >
> > > > >
> > > > > On 01/08/24 13:08, Nathan Chancellor wrote:
> > > > > > On Thu, Aug 01, 2024 at 06:47:58AM -0600, Gustavo A. R. Silva w=
rote:
> > > > > > >
> > > > > > >
> > > > > > > On 01/08/24 05:35, kernel test robot wrote:
> > > > > > > > tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
> > testing/wfamnae-next20240729-cbc-2
> > > > > > > > head:   df15c862c1b93b6e1f6c90b0d7971f7a6ad66751
> > > > > > > > commit: e7cd9f429a852fb7e37a706c7d08fc36e7863e06 [11/18]
> > RDMA/uverbs: Use static_assert() to check struct sizes
> > > > > > > > config: hexagon-randconfig-001-20240801
> > (https://download.01.org/0day-
> ci/archive/20240801/202408011956.wscyBwq6-
> > lkp@intel.com/config)
> > > > > > > > compiler: clang version 20.0.0git=20
> > > > > > > > (https://github.com/llvm/llvm-
> > project 430b90f04533b099d788db2668176038be38c53b)
> > > > > > >
> > > > > > >
> > > > > > > Clang 20.0.0?? (thinkingface)
> > > > > >
> > > > > > Indeed, Clang 19 branched and main is now 20 :)
> > > > > >
> > > > > > https://github.com/llvm/llvm-
> > project/commit/8f701b5df0adb3a2960d78ca2ad9cf53f39ba2fe
> > > > >
> > > > > Yeah, but is that a stable release?
> > > >
> > > > No, but the Intel folks have tested tip of tree LLVM against the=20
> > > > kernel for us for a few years now to try and catch issues such as t=
his.
> > >
> > > Oh, I see, fine. :)
> > >
> > > >
> > > > > BTW, I don't see GCC reporting the same problem below:
> > > >
> > > > Hexagon does not have a GCC backend anymore so it is not going=20
> > > > to be possible to do an exact A/B comparison with this configuratio=
n but...
> > > >
> > > > > > > > > > include/rdma/uverbs_ioctl.h:643:15: error: static=20
> > > > > > > > > > assertion
> failed
> > due to requirement '__builtin_offsetof(struct uverbs_attr_bundle,=20
> > attrs) =3D=3D sizeof(struct uverbs_attr_bundle_hdr)': struct member=20
> > likely outside of
> > struct_group_tagged()
> > > > > > > >         643 | static_assert(offsetof(struct=20
> > > > > > > > uverbs_attr_bundle, attrs)
> =3D=3D
> > sizeof(struct uverbs_attr_bundle_hdr),
> > > > > > > >             |
> >
> ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > >         644 |               "struct member likely outside o=
f
> > struct_group_tagged()");
> > > > > > > >             |
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > >       include/linux/stddef.h:16:32: note: expanded from=20
> > > > > > > > macro
> > 'offsetof'
> > > > > > > >          16 | #define offsetof(TYPE, MEMBER)
> __builtin_offsetof(TYPE,
> > MEMBER)
> > > > > > > >             |                                 ^
> > > > > > > >       include/linux/build_bug.h:77:50: note: expanded=20
> > > > > > > > from macro
> > 'static_assert'
> > > > > > > >          77 | #define static_assert(expr, ...)=20
> > > > > > > > __static_assert(expr,
> > ##__VA_ARGS__, #expr)
> > > > > > > >             |
> > ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > >       include/linux/build_bug.h:78:56: note: expanded=20
> > > > > > > > from macro
> > '__static_assert'
> > > > > > > >          78 | #define __static_assert(expr, msg, ...)=20
> > > > > > > > _Static_assert(expr,
> > msg)
> > > > > > > >             |                                              =
          ^~~~
> > > > > > > >       include/rdma/uverbs_ioctl.h:643:58: note:=20
> > > > > > > > expression evaluates
> > to '56 =3D=3D 52'
> > > >
> > > > This seems to give some indication that perhaps there may be=20
> > > > some architecture specific here with padding maybe? I seem to=20
> > > > recall ARM OABI having something similar. Adding the Hexagon=20
> > > > folks/list to get some more clarification. Full warning and context=
:
> > > >
> > > > https://lore.kernel.org/202408011956.wscyBwq6-lkp@intel.com/
> > > >
>=20
> There might be hexagon-specific padding requirements, but not ones=20
> that I've stumbled across before.  I've added Sundeep from the=20
> compiler team who may be able to help.

Steve suggested I try dumping the record layouts using clang's "-fdump-reco=
rd-layouts".  I did so using the clang 18.1.8 binary from https://github.co=
m/llvm/llvm-project/releases/tag/llvmorg-18.1.8 -- I thought it was reasona=
ble to use this older release because it still generates the static asserti=
on.  But I can repeat it with clang-20 built from the bot's cited commit if=
 preferred.

Steve - can you give any advice about the compiler's behavior wrt this stru=
ct layout and the assertion?

I've attached the unabridged output from clang with "-fdump-record-layouts"=
.  Here's an excerpt:

*** Dumping AST Record Layout
         0 | struct uverbs_attr_bundle_hdr
         0 |   struct ib_udata driver_udata
         0 |     const void * inbuf
         4 |     void * outbuf
         8 |     size_t inlen
        12 |     size_t outlen
        16 |   struct ib_udata ucore
        16 |     const void * inbuf
        20 |     void * outbuf
        24 |     size_t inlen
        28 |     size_t outlen
        32 |   struct ib_uverbs_file * ufile
        36 |   struct ib_ucontext * context
        40 |   struct ib_uobject * uobject
        44 |   unsigned long[2] attr_present
           | [sizeof=3D52, align=3D4]

*** Dumping AST Record Layout
         0 | union uverbs_attr_bundle::(anonymous at ../include/rdma/uverbs=
_ioctl.h:633:2)
         0 |   struct uverbs_attr_bundle::(anonymous at ../include/rdma/uve=
rbs_ioctl.h:633:2)=20
         0 |     struct ib_udata driver_udata
         0 |       const void * inbuf
         4 |       void * outbuf
         8 |       size_t inlen
        12 |       size_t outlen
        16 |     struct ib_udata ucore
        16 |       const void * inbuf
        20 |       void * outbuf
        24 |       size_t inlen
        28 |       size_t outlen
        32 |     struct ib_uverbs_file * ufile
        36 |     struct ib_ucontext * context
        40 |     struct ib_uobject * uobject
        44 |     unsigned long[2] attr_present
         0 |   struct uverbs_attr_bundle_hdr hdr
         0 |     struct ib_udata driver_udata
         0 |       const void * inbuf
         4 |       void * outbuf
         8 |       size_t inlen
        12 |       size_t outlen
        16 |     struct ib_udata ucore
        16 |       const void * inbuf
        20 |       void * outbuf
        24 |       size_t inlen
    In file included from ../drivers/infiniband/core/ib_core_uverbs.c:8:
In file included from ../drivers/infiniband/core/uverbs.h:49:
In file included from ../include/rdma/uverbs_std_types.h:10:
../include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due t=
o requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) =3D=3D =
sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of str=
uct_group_tagged()
  643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) =3D=3D siz=
eof(struct uverbs_attr_bundle_hdr),
      | ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  644 |               "struct member likely outside of struct_group_tagged(=
)");
      |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
../include/linux/stddef.h:16:32: note: expanded from macro 'offsetof'
   16 | #define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
      |                                 ^
../include/linux/build_bug.h:77:50: note: expanded from macro 'static_asser=
t'
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS_=
_, #expr)
      |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~=
~~~~~~~~~
../include/linux/build_bug.h:78:56: note: expanded from macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
../include/rdma/uverbs_ioctl.h:643:58: note: expression evaluates to '56 =
=3D=3D 52'
  643 | static_assert(offsetof(struct uverbs_attr_bundle, attrs) =3D=3D siz=
eof(struct uverbs_attr_bundle_hdr),
      | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  644 |               "struct member likely outside of struct_group_tagged(=
)");
      |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
../include/linux/build_bug.h:77:50: note: expanded from macro 'static_asser=
t'
   77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS_=
_, #expr)
      |                                  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~=
~~~~~~~~~
../include/linux/build_bug.h:78:56: note: expanded from macro '__static_ass=
ert'
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
    28 |       size_t outlen
        32 |     struct ib_uverbs_file * ufile
        36 |     struct ib_ucontext * context
        40 |     struct ib_uobject * uobject
        44 |     unsigned long[2] attr_present
           | [sizeof=3D52, align=3D4]

I've also attached the "clang -cc1" invocation and preprocessed C output fo=
r reference.

> > > > The problematic section preprocessed since sometimes the macros=20
> > > > obfuscate things:
> > > >
> > > > struct uverbs_attr_bundle {
> > > >          union {
> > > >                  struct {
> > > >                          struct ib_udata driver_udata;
> > > >                          struct ib_udata ucore;
> > > >                          struct ib_uverbs_file *ufile;
> > > >                          struct ib_ucontext *context;
> > > >                          struct ib_uobject *uobject;
> > > >                          unsigned long
> attr_present[(((UVERBS_API_ATTR_BKEY_LEN)
> > +
> > > >                                                       ((sizeof(long=
) * 8)) - 1) /
> > > >                                                      ((sizeof(long)=
 * 8)))];
> > > >                  };
> > > >                  struct uverbs_attr_bundle_hdr {
> > > >                          struct ib_udata driver_udata;
> > > >                          struct ib_udata ucore;
> > > >                          struct ib_uverbs_file *ufile;
> > > >                          struct ib_ucontext *context;
> > > >                          struct ib_uobject *uobject;
> > > >                          unsigned long
> attr_present[(((UVERBS_API_ATTR_BKEY_LEN)
> > +
> > > >                                                       ((sizeof(long=
) * 8)) - 1) /
> > > >                                                      ((sizeof(long)=
 * 8)))];
> > > >                  } hdr;
> > > >          };
> > > >
> > > >          struct uverbs_attr attrs[]; };=20
> > > > _Static_assert(__builtin_offsetof(struct uverbs_attr_bundle, attrs)=
 =3D=3D
> > > >                         sizeof(struct uverbs_attr_bundle_hdr),
> > > >                 "struct member likely outside of=20
> > > > struct_group_tagged()");
> > > >
> > > > FWIW, I see this with all versions of Clang that the kernel=20
> > > > supports with this configuration.
> > >
> > > I don't have access to a Clang compiler right now; I wonder if you=20
> > > could help me get the output of this command:
> > >
> > > pahole -C uverbs_attr_bundle drivers/infiniband/core/rdma_core.o
> >
> > We disabled CONFIG_DEBUG_INFO_BTF for Hexagon because elfutils does
> not
> > support Hexagon relocations but this is built-in for this=20
> > configuration so I removed that limitation and ended up with:
> >
> > $ pahole -C uverbs_attr_bundle vmlinux struct uverbs_attr_bundle {
> >         union {
> >                 struct {
> >                         struct ib_udata driver_udata;    /*     0    16=
 */
> >                         struct ib_udata ucore;           /*    16    16=
 */
> >                         struct ib_uverbs_file * ufile;   /*    32     4=
 */
> >                         struct ib_ucontext * context;    /*    36     4=
 */
> >                         struct ib_uobject * uobject;     /*    40     4=
 */
> >                         unsigned long attr_present[2];   /*    44     8=
 */
> >                 };                                       /*     0    52=
 */
> >                 struct uverbs_attr_bundle_hdr hdr;       /*     0    52=
 */
> >         };                                               /*     0    52=
 */
> >
> >         /* XXX 4 bytes hole, try to pack */
> >         union {
> >                 struct {
> >                         struct ib_udata    driver_udata;         /*    =
 0    16 */
> >                         struct ib_udata    ucore;                /*    =
16    16 */
> >                         struct ib_uverbs_file * ufile;           /*    =
32     4 */
> >                         struct ib_ucontext * context;            /*    =
36     4 */
> >                         struct ib_uobject * uobject;             /*    =
40     4 */
> >                         unsigned long      attr_present[2];      /*    =
44     8 */
> >                 };                                               /*    =
 0    52 */
> >                 struct uverbs_attr_bundle_hdr hdr;               /*    =
 0    52 */
> >         };
> >
> >
> >         struct uverbs_attr         attrs[];              /*    56     0=
 */
> >
> >         /* size: 56, cachelines: 1, members: 2 */
> >         /* sum members: 52, holes: 1, sum holes: 4 */
> >         /* last cacheline: 56 bytes */ };
> >
> > If you want any other information or want me to test anything, I am=20
> > more than happy to do so.
> >
> > Cheers,
> > Nathan
> >
> > > > > > > >         643 | static_assert(offsetof(struct=20
> > > > > > > > uverbs_attr_bundle, attrs)
> =3D=3D
> > sizeof(struct uverbs_attr_bundle_hdr),
> > > > > > > >             |
> >
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > >         644 |               "struct member likely outside o=
f
> > struct_group_tagged()");
> > > > > > > >             |
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > >       include/linux/build_bug.h:77:50: note: expanded=20
> > > > > > > > from macro
> > 'static_assert'
> > > > > > > >          77 | #define static_assert(expr, ...)=20
> > > > > > > > __static_assert(expr,
> > ##__VA_ARGS__, #expr)
> > > > > > > >             |
> > ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > > >       include/linux/build_bug.h:78:56: note: expanded=20
> > > > > > > > from macro
> > '__static_assert'
> > > > > > > >          78 | #define __static_assert(expr, msg, ...)=20
> > > > > > > > _Static_assert(expr,
> > msg)
> > > > > > > >             |                                              =
          ^~~~
> > > > > > > >       7 warnings and 1 error generated.
> > > > > > > >
> > > > > > > >
> > > > > > > > vim +643 include/rdma/uverbs_ioctl.h
> > > > > > > >
> > > > > > > >       630
> > > > > > > >       631   struct uverbs_attr_bundle {
> > > > > > > >       632           /* New members MUST be added within the
> > struct_group() macro below. */
> > > > > > > >       633           struct_group_tagged(uverbs_attr_bundle_=
hdr, hdr,
> > > > > > > >       634                   struct ib_udata driver_udata;
> > > > > > > >       635                   struct ib_udata ucore;
> > > > > > > >       636                   struct ib_uverbs_file *ufile;
> > > > > > > >       637                   struct ib_ucontext *context;
> > > > > > > >       638                   struct ib_uobject *uobject;
> > > > > > > >       639                   DECLARE_BITMAP(attr_present,
> > UVERBS_API_ATTR_BKEY_LEN);
> > > > > > > >       640           );
> > > > > > > >       641           struct uverbs_attr attrs[];
> > > > > > > >       642   };
> > > > > > > >     > 643   static_assert(offsetof(struct uverbs_attr_bundl=
e, attrs) =3D=3D
> > sizeof(struct uverbs_attr_bundle_hdr),
> > > > > > > >       644                 "struct member likely outside of
> > struct_group_tagged()");
> > > > > > > >       645
> > > > > > > >
> > > > > > >
> > > > >
> > > > > Thanks
> > > > > --
> > > > > Gustavo


