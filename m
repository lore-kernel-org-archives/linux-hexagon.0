Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79455F9E6;
	Tue,  6 Aug 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958583; cv=fail; b=XTwxTE9pFMCIeOmVhkbGhSdZk9+Yl2S77/rgfBzw6fxZ6EgGJB+q7u+OUNcAimWqQFQVFznLdF00oKkuSy6IcXRb8fcbHfZ9YbBF7IEw5XND2flcbRp9OUJGAqtmGQLXUk3342mbcLKV4B+MmHw7CKNXaFtnbfm8sBrlk7qUmWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958583; c=relaxed/simple;
	bh=OzUF4LTVMa9Mdc06023IkY89n6iP+GlFDWsJrhjdKnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZYS7HL+Da6skv7G2vfBL0pRltXogn6SOZb7ga0gb0TPTyDAw/szMEbVsBR7EDGMLjyd5rGO34f0KJckNA24aW4Waql2gwnDSPSvpioRHc3AAGqSGwA7ilyAICEkTWeOVyyOyQyp1yH3B30YC5tHbVlrz9Yln6hVLk7cYt39svzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e3b6BB/s; arc=fail smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e3b6BB/s"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4768WDj2025788;
	Tue, 6 Aug 2024 15:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	atvXeNIzoUqhIBsQLqtuFqracRS/Dpxuj8IkwymhPsw=; b=e3b6BB/sPZ7JFTOq
	a11CV3XJdbLAUv5wzAylmNLzpdLZiayuwUv10h5j4YqkQF6x7o3PXYU2MXf/CfAM
	0Au8/P3013e10rVENfQULdQU+0OMsozf5PWBtSyc8kW2jKfgFO7T/8LtkVeX6QR8
	t/3pui8msEa2246zaAI+zfh7EHJfOQ5EcOsVh7TQe37el/ACzg6htVtC7I56BLan
	7ydP5pcG2S6Hpp7SrssQ6Hh23Z1MLoDzQlCVWSqQPWl+RZHQm65HOO+bwePw5Nuo
	MCkSjovuDJw37ihdIZzmSn+M9EX/LtDnnnNBAYxCzSnDrUZd/K33UwTgR4p/5aW1
	OM6bAA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011028.outbound.protection.outlook.com [40.93.12.28])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40u4cpjuaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Aug 2024 15:36:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPQXTw3OiKWhF/MqKcYTWtcTrkCrzYKaseDpyKOEWd1HynqyagImNk7Z8NtbqSpW6sGAu+39tNecnCirpmo5GO8e/SyxexAjG+z+/M+cQ28sFeoQqJFq732WKfOQMoel4Xu04ZJUkQz1z1+r6fgeTPrgL+0tVgw/KLLGqyx6DsMGUeeDDz7o/AcmOIxbpJ5MJtbzy0RuRbaG3oEc/wh4YTb1JkSD732zwzV7dEXRWMbhU0e7hSlr0Pup+Yn+MiBcrnXQ+2Nm/fekTnZL/jFBZHh2VkTCJwGaK77rdPGYH8gUQ7Z7+Arp+5o0RBVW07hhjyy4gosuY9HhVT84jPONdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atvXeNIzoUqhIBsQLqtuFqracRS/Dpxuj8IkwymhPsw=;
 b=oswrSq5TO/YL0PFZTPMDZEacJ3jEd6UWSgVVIfduf4eVFVkzS6t+kHDgfwIiBb9NoEfBWhxOmTRfttCra92TGQocctdTBGbNoF/9YbcJTgGdSVd4kV7dJJEzdEDqZWgYqCtzq/YK7SwttTelVD0wCFwTHPu8ZoL2bg1w1ghPavKUfFQScHBBa1b8hBPxDpDcruwCTUyyQc5exqG32FsfvBVOhVoEJFclcjKy3LAGM04bdZA/oZrrhzhWuAEek77dPtPKTPG6TyMZGx0mpyk3JGEnAFgWSemff012q1j4Uvmolo8ETJOw3UDLgUfumu5wsxKXpQPLVF/YGdpaTigYiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 (2603:10b6:610:1c2::10) by SA0PR02MB7274.namprd02.prod.outlook.com
 (2603:10b6:806:e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Tue, 6 Aug
 2024 15:36:02 +0000
Received: from CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11]) by CH3PR02MB10247.namprd02.prod.outlook.com
 ([fe80::2980:17c4:6e92:2b11%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 15:36:01 +0000
From: Brian Cain <bcain@quicinc.com>
To: Nathan Chancellor <nathan@kernel.org>,
        "Gustavo A. R. Silva"
	<gustavo@embeddedor.com>
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
Thread-Index: AQHa5GAx8pxBq9usEUCI4KlonF1oTLIS/ZyAgAGN1ACABdgR0A==
Date: Tue, 6 Aug 2024 15:36:01 +0000
Message-ID:
 <CH3PR02MB10247E2B6524ACA52F747A0C0B8BF2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <202408011956.wscyBwq6-lkp@intel.com>
 <138da3e5-0e24-41a6-bb35-df5d07045eb3@embeddedor.com>
 <20240801190813.GC122261@thelio-3990X>
 <f40160aa-7cbd-4264-be44-45396b09574f@embeddedor.com>
 <20240801221427.GA3773553@thelio-3990X>
 <ca056227-30c3-47b9-a19a-fbab87778f20@embeddedor.com>
 <20240802221952.GA737452@thelio-3990X>
In-Reply-To: <20240802221952.GA737452@thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR02MB10247:EE_|SA0PR02MB7274:EE_
x-ms-office365-filtering-correlation-id: 566db375-367d-4823-73de-08dcb62d7a27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+e5Q4n2XKraFtGLJnjcStmPnIyq0btxU/mS5sXXMWvRnaUWPXZdE4LHT1eBH?=
 =?us-ascii?Q?17U/zgxk+QD3dm4bX7gXx5q+j3dsg0GAQkgiJMlxX66RnLnIjsFQ0A1bJVac?=
 =?us-ascii?Q?BYt1+XAxs5kkAq3/YJ71skP6GzmD7xN59UVzmM5Z0uzQruXbi9tD6HPjiO7U?=
 =?us-ascii?Q?P+MQvCILJPjSi/6OZspC9fLrcae94wsiTIfg++IDOBpR/uXRDkJ2zZ3W3jZY?=
 =?us-ascii?Q?TonsOCR45HxmccyDC/em+4Ck07iiVhzxJ3n63MstqBCRDNNiV1q0FK2rT4Ka?=
 =?us-ascii?Q?SsiUpd+bk1EKWarYLgR5mhkt0CjFCjucvDf84e6tU8r5l6/uevtjYyD3o5J/?=
 =?us-ascii?Q?Vxuj1QZyFv8wIpQtgREP019PoiN+qAN7g+uMZHHaOOGcSWD2Cy5S+IMdEpbP?=
 =?us-ascii?Q?Smt+/Grv3NrOk3UeO/VjKpJPA4xFdJ6Zl3N9aH+1J5AOaWxUHtPoYNCn2qyx?=
 =?us-ascii?Q?q+SI6FY+Z0kjtPOEPhKiYTOI55IjBkUaL45F6QEnLUnDqD8WH+A1vTpXSEk0?=
 =?us-ascii?Q?YFlwRpSXNSSDDew0oYy4r21PJhRDaawLnWI8MmBRKJaadqdCnNnPrzswUJOP?=
 =?us-ascii?Q?t94e4nQn6fwn6CWAOUp5nEb9sZhhntcWnSy9hXFOGijdLYukz/VisFZPr5m5?=
 =?us-ascii?Q?nEoDMLY1ngWE/H8RGX6/0DY4l3aiikeDa5h11gp/+w4dAbyL/qH3g+lLtIUG?=
 =?us-ascii?Q?ALlMOVf5F0cCnXik2d9GJzsTSzowMB7fpMC/EOIPUI8NNqegLuTWXp45MeSP?=
 =?us-ascii?Q?sUKzojGtckOasJNQMbkAKQm+eLBlmi0qQlW8PBR5DxliRXbZ0vimI82Xr89h?=
 =?us-ascii?Q?42f91DaJ006rzgR8/QidZtoivzXVi0ibQL9XKkwGmtVh60pUOIfYYx3SUUg1?=
 =?us-ascii?Q?nlbuzQKBuZg4gdvAbcycMYdNwSWYfbmv8m4MEfNG+hauOqN3ECK5Iv9hokq+?=
 =?us-ascii?Q?9o/qWTnjp2JPqtERkISdKfNRJl5CmgUVlM2QG88UkdSNkQjdD5td57ErpqKG?=
 =?us-ascii?Q?PcaZWLKckIGsxpzGqQ64BvMOFKjmrs4Fa6qnBJblhfCiu/bB63TESDH2DByp?=
 =?us-ascii?Q?PzgRb4LcjnKcOGUzg6n1rq0oeDpxnCIzJ+o0+xoDA7NguB1nZ5pTdc6cr3ah?=
 =?us-ascii?Q?o88nXMx78zMxQZWv3l3jCMTVQRZS1oQCDg26aRIOC8dYU9am0T1JfZ9KeS6t?=
 =?us-ascii?Q?U1dCVRgZoTSe0eSdMQwyM9QvS2wrpFeOXcx6Jl2uMrVEiuw1smjr4ocCJlo3?=
 =?us-ascii?Q?YB11SMY2RgTso2J4NYlSg3G9iImkOfxnY2ZMO6hhLjAj6ww553lv/9gh6067?=
 =?us-ascii?Q?OJPYXnkPorL6uojdePMzVJGl18wpLaaJJVG/x1YV5A22G2WmZD0G9rvnlkfG?=
 =?us-ascii?Q?uE1vR4M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR02MB10247.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KF9pwsuf1/HpNaWOXPvOfk3zULqGm2YsSu71/oz4lj74wU1VRbUw+v6/w4lP?=
 =?us-ascii?Q?SHx+JRPnmV5R4GRgfAHyAjeEBvPH0xrO89JZvhF7qyvfOSRsqHzIMzrAcg/M?=
 =?us-ascii?Q?pogCN40tqhm94MiAaPvl6a0w6pflqp0BM4jaRaHmMhhc2nVu+GjgnnV/l8d9?=
 =?us-ascii?Q?p9ie2QXK4aHB/7EwXP2N6VNktzD93wswYfbQ5Il+z0LZmZzJr8EvutkXvyf1?=
 =?us-ascii?Q?8XWlN+67nfA9xkRas5s4cwRVFQeifRlZ/MvhvNj32d10m4A6KEJ3jJxicPJn?=
 =?us-ascii?Q?Y6m/yQU3bZf3IzRKK9u8HYNaFhnhao8BcWBsMqu+cmSv8ghPuQHhGmW7MID8?=
 =?us-ascii?Q?A6KF5qdxmk3JCja+8xS1M6c8VT5rsThEHVsbu/ZXErHxHVh4B0l3XHHW5Q91?=
 =?us-ascii?Q?9iIyEK6Ra79lO0MAbTTMP5TZjT8H4jrSdEs3L/a0exyQpXbHZ+fOc4+a1Vps?=
 =?us-ascii?Q?BZulKhkvPL2BEk+Z8Q66PZXG+5DrjDG9ohhERkZx86G2dLRO+Xagj28Kodvp?=
 =?us-ascii?Q?mMzCAn59ASNdyFPtrUAZn3ApUBuzqVOg5Fr8+vMoRz0sNsWC2IPdyEJLPd4q?=
 =?us-ascii?Q?edvQOx25BiCfEkXOnl0IxkoRL/DetdRSbIwQey+dWUPnxrSRxZkSLQ/v93Zt?=
 =?us-ascii?Q?J+FrHXcN2LGgsrkRg1etitWdqx+PFJn9CzVpLZ/fUDLE2U6nA9cnmtDKYVBn?=
 =?us-ascii?Q?kaN1bsxBUXQIMrFpJtvlStieftI71tgzP5hAtwn3+/IBDu/dHcumvSyOumir?=
 =?us-ascii?Q?XvpwyQvs1ARrCy1IhI/dzrV3e0svncGD61faBNJd67LVjXpplvyatePADGU7?=
 =?us-ascii?Q?XO0wU18JWwxAIPH+WY5asLzV2TY/OBeCse+3WMIsbuJTT0x5o98nwLxIvyuj?=
 =?us-ascii?Q?Lh9Vj91Me9uDQFp50lw8W1hZFs5dwjOtUTHA0qZ9p8WbnUBaMkTisCWfXGSX?=
 =?us-ascii?Q?yjOlvc8wDIUyCe9lTWYFGJuHGKJOkrkiM4ZCrC+i8N+Epo0BxeoMhF3rTlMH?=
 =?us-ascii?Q?QqYFxzfUOPpmxzwMP6TyXI6YCvZyFtnfEfIRq/WqUCj+riqnkUEt4Qt8WMjn?=
 =?us-ascii?Q?r4t00UwrkzhNg4uUk0pQNHJE2frqOnMvYkP/j/MhO876sdi8zogV3ZzNwj48?=
 =?us-ascii?Q?RPJ7Gu/OaeJIud8Q7hNXNvKCyXqhGO8fE/AQs2M9JV56eGI2e6df+L8T3esJ?=
 =?us-ascii?Q?pJsXxbNUpMfk61gS6l0SXvaY+W3/hMQMAu9mFMH/8a1Cn1svYexHvltoS4Gu?=
 =?us-ascii?Q?Pmb3Wrqj9+BomFFad3gh5GhK4gUlMPD5IBZ88sRHyER5+p2m1VQVqBguWAL/?=
 =?us-ascii?Q?F1XrWS4/lFGV9hFAOPdKSgkkuMTPjVcVUnw0RYEt6QdQGw/XLQLhQeDRH/0a?=
 =?us-ascii?Q?lG4aSXd98k0PPkMydgttZCYr3IesQWB3oPvojW77lkeZVZK2umJSoZhkhsco?=
 =?us-ascii?Q?m3A/UvQ1nPygZ/HBGYkLzXZMeUXWLA+sd8/MN2av7/Agq94CF9dDNG1cc0pf?=
 =?us-ascii?Q?DDISIBzS3iiCkPp9Mibn/XYBDQxGNRKBA1HePdRoOGcxewDkpbWK93XPfUPJ?=
 =?us-ascii?Q?D/ka9RZYALPEjBIZXUYICrKdd3I9vqrC5/t67Hti?=
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
	Pd3fnEqzYPNKV2Cl79gpJHqUqbfUPpKnJ+fY+OZC79NATjvnKUCeqhtFyzZPYRrMu71AwmgWBMcfMtroxjtRgcOYzGNdT6sn7hkq7hjngsxGpfzjwSWmINegxCnoyGJGzZ8dfS/cBpFYyJcA1Ph2g/q2Wm+oKfzh5RZuKtyNEdJ9XhRZAJkSR/ykxKz1B9KGNWC6uEjA1jFX0eRAesFnHjsNIw41Quc7dr4d6mB8xO1zm8XH0y+W+DrJ9R3N2So8p5IbmW4mNi9aM8tOyibPla3sTsZoYJHxLf9+7LQ5A9YD16DDjWcuGDtshPNEllS5W0IsgxQOAimAEPnjgfzZYCiPTqAqv1/WL7OYpypJUH8wIyFeUOavNsI8TrzUPpJ7eJ6qbefldjxD9axFKH7n5QwvXYlWI5kQPMVus+vL57tn38CahmZSvw3Uo7gNkwFTkglfnZVa6HdUcEavLgkbtZ5qGhPLu8iHeR4+ppqvw8DqaDhLCk6w8+DjIUBnj8BgD7Na3jW9ErL/qBQ8oxyUkSiIjiGg8xpR+erd58846G+OMaPwz0NTh2s6tjtTtjq9DmIISBUaPQTMLTTz3Uph5PDXtBo+Zd9dpz1kmA69QckI6Z/Otj6M92y0WG/D0ID3
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR02MB10247.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566db375-367d-4823-73de-08dcb62d7a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 15:36:01.8745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0wEsXhO+1KLR+11xdkuv/QJ9Cyf6BnvupMcWVORpvgS06wb4xZ1AWv4E2cCVRUSPWWPcXuprRrZMwLd5ENIKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7274
X-Proofpoint-ORIG-GUID: KtfPOfQ3rselVjaKKkLadkaTpwyCzl4n
X-Proofpoint-GUID: KtfPOfQ3rselVjaKKkLadkaTpwyCzl4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_12,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408060109



> -----Original Message-----
> From: Nathan Chancellor <nathan@kernel.org>
> Sent: Friday, August 2, 2024 5:20 PM
> To: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: kernel test robot <lkp@intel.com>; Gustavo A. R. Silva
> <gustavoars@kernel.org>; llvm@lists.linux.dev; oe-kbuild-all@lists.linux.=
dev;
> LKML <linux-kernel@vger.kernel.org>; Brian Cain <bcain@quicinc.com>; linu=
x-
> hexagon@vger.kernel.org
> Subject: Re: [gustavoars:testing/wfamnae-next20240729-cbc-2 11/18]
> include/rdma/uverbs_ioctl.h:643:15: error: static assertion failed due to
> requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) =3D=3D
> sizeof(struct uverbs_attr_bundle_hdr)': struct memb...
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary o=
f
> any links or attachments, and do not enable macros.
>=20
> On Thu, Aug 01, 2024 at 04:35:59PM -0600, Gustavo A. R. Silva wrote:
> >
> >
> > On 01/08/24 16:14, Nathan Chancellor wrote:
> > > On Thu, Aug 01, 2024 at 02:17:50PM -0600, Gustavo A. R. Silva wrote:
> > > >
> > > >
> > > > On 01/08/24 13:08, Nathan Chancellor wrote:
> > > > > On Thu, Aug 01, 2024 at 06:47:58AM -0600, Gustavo A. R. Silva wro=
te:
> > > > > >
> > > > > >
> > > > > > On 01/08/24 05:35, kernel test robot wrote:
> > > > > > > tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
> testing/wfamnae-next20240729-cbc-2
> > > > > > > head:   df15c862c1b93b6e1f6c90b0d7971f7a6ad66751
> > > > > > > commit: e7cd9f429a852fb7e37a706c7d08fc36e7863e06 [11/18]
> RDMA/uverbs: Use static_assert() to check struct sizes
> > > > > > > config: hexagon-randconfig-001-20240801
> (https://download.01.org/0day-ci/archive/20240801/202408011956.wscyBwq6-
> lkp@intel.com/config)
> > > > > > > compiler: clang version 20.0.0git (https://github.com/llvm/ll=
vm-
> project 430b90f04533b099d788db2668176038be38c53b)
> > > > > >
> > > > > >
> > > > > > Clang 20.0.0?? (thinkingface)
> > > > >
> > > > > Indeed, Clang 19 branched and main is now 20 :)
> > > > >
> > > > > https://github.com/llvm/llvm-
> project/commit/8f701b5df0adb3a2960d78ca2ad9cf53f39ba2fe
> > > >
> > > > Yeah, but is that a stable release?
> > >
> > > No, but the Intel folks have tested tip of tree LLVM against the kern=
el
> > > for us for a few years now to try and catch issues such as this.
> >
> > Oh, I see, fine. :)
> >
> > >
> > > > BTW, I don't see GCC reporting the same problem below:
> > >
> > > Hexagon does not have a GCC backend anymore so it is not going to be
> > > possible to do an exact A/B comparison with this configuration but...
> > >
> > > > > > > > > include/rdma/uverbs_ioctl.h:643:15: error: static asserti=
on failed
> due to requirement '__builtin_offsetof(struct uverbs_attr_bundle, attrs) =
=3D=3D
> sizeof(struct uverbs_attr_bundle_hdr)': struct member likely outside of
> struct_group_tagged()
> > > > > > >         643 | static_assert(offsetof(struct uverbs_attr_bundl=
e, attrs) =3D=3D
> sizeof(struct uverbs_attr_bundle_hdr),
> > > > > > >             |
> ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > >         644 |               "struct member likely outside of
> struct_group_tagged()");
> > > > > > >             |
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > >       include/linux/stddef.h:16:32: note: expanded from macro
> 'offsetof'
> > > > > > >          16 | #define offsetof(TYPE, MEMBER)  __builtin_offse=
tof(TYPE,
> MEMBER)
> > > > > > >             |                                 ^
> > > > > > >       include/linux/build_bug.h:77:50: note: expanded from ma=
cro
> 'static_assert'
> > > > > > >          77 | #define static_assert(expr, ...) __static_asser=
t(expr,
> ##__VA_ARGS__, #expr)
> > > > > > >             |
> ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > >       include/linux/build_bug.h:78:56: note: expanded from ma=
cro
> '__static_assert'
> > > > > > >          78 | #define __static_assert(expr, msg, ...) _Static=
_assert(expr,
> msg)
> > > > > > >             |                                                =
        ^~~~
> > > > > > >       include/rdma/uverbs_ioctl.h:643:58: note: expression ev=
aluates
> to '56 =3D=3D 52'
> > >
> > > This seems to give some indication that perhaps there may be some
> > > architecture specific here with padding maybe? I seem to recall ARM O=
ABI
> > > having something similar. Adding the Hexagon folks/list to get some m=
ore
> > > clarification. Full warning and context:
> > >
> > > https://lore.kernel.org/202408011956.wscyBwq6-lkp@intel.com/
> > >

There might be hexagon-specific padding requirements, but not ones that I'v=
e stumbled across before.  I've added Sundeep from the compiler team who ma=
y be able to help.

> > > The problematic section preprocessed since sometimes the macros
> > > obfuscate things:
> > >
> > > struct uverbs_attr_bundle {
> > >          union {
> > >                  struct {
> > >                          struct ib_udata driver_udata;
> > >                          struct ib_udata ucore;
> > >                          struct ib_uverbs_file *ufile;
> > >                          struct ib_ucontext *context;
> > >                          struct ib_uobject *uobject;
> > >                          unsigned long attr_present[(((UVERBS_API_ATT=
R_BKEY_LEN)
> +
> > >                                                       ((sizeof(long) =
* 8)) - 1) /
> > >                                                      ((sizeof(long) *=
 8)))];
> > >                  };
> > >                  struct uverbs_attr_bundle_hdr {
> > >                          struct ib_udata driver_udata;
> > >                          struct ib_udata ucore;
> > >                          struct ib_uverbs_file *ufile;
> > >                          struct ib_ucontext *context;
> > >                          struct ib_uobject *uobject;
> > >                          unsigned long attr_present[(((UVERBS_API_ATT=
R_BKEY_LEN)
> +
> > >                                                       ((sizeof(long) =
* 8)) - 1) /
> > >                                                      ((sizeof(long) *=
 8)))];
> > >                  } hdr;
> > >          };
> > >
> > >          struct uverbs_attr attrs[];
> > > };
> > > _Static_assert(__builtin_offsetof(struct uverbs_attr_bundle, attrs) =
=3D=3D
> > >                         sizeof(struct uverbs_attr_bundle_hdr),
> > >                 "struct member likely outside of struct_group_tagged(=
)");
> > >
> > > FWIW, I see this with all versions of Clang that the kernel supports
> > > with this configuration.
> >
> > I don't have access to a Clang compiler right now; I wonder if you coul=
d
> > help me get the output of this command:
> >
> > pahole -C uverbs_attr_bundle drivers/infiniband/core/rdma_core.o
>=20
> We disabled CONFIG_DEBUG_INFO_BTF for Hexagon because elfutils does not
> support Hexagon relocations but this is built-in for this configuration
> so I removed that limitation and ended up with:
>=20
> $ pahole -C uverbs_attr_bundle vmlinux
> struct uverbs_attr_bundle {
>         union {
>                 struct {
>                         struct ib_udata driver_udata;    /*     0    16 *=
/
>                         struct ib_udata ucore;           /*    16    16 *=
/
>                         struct ib_uverbs_file * ufile;   /*    32     4 *=
/
>                         struct ib_ucontext * context;    /*    36     4 *=
/
>                         struct ib_uobject * uobject;     /*    40     4 *=
/
>                         unsigned long attr_present[2];   /*    44     8 *=
/
>                 };                                       /*     0    52 *=
/
>                 struct uverbs_attr_bundle_hdr hdr;       /*     0    52 *=
/
>         };                                               /*     0    52 *=
/
>=20
>         /* XXX 4 bytes hole, try to pack */
>         union {
>                 struct {
>                         struct ib_udata    driver_udata;         /*     0=
    16 */
>                         struct ib_udata    ucore;                /*    16=
    16 */
>                         struct ib_uverbs_file * ufile;           /*    32=
     4 */
>                         struct ib_ucontext * context;            /*    36=
     4 */
>                         struct ib_uobject * uobject;             /*    40=
     4 */
>                         unsigned long      attr_present[2];      /*    44=
     8 */
>                 };                                               /*     0=
    52 */
>                 struct uverbs_attr_bundle_hdr hdr;               /*     0=
    52 */
>         };
>=20
>=20
>         struct uverbs_attr         attrs[];              /*    56     0 *=
/
>=20
>         /* size: 56, cachelines: 1, members: 2 */
>         /* sum members: 52, holes: 1, sum holes: 4 */
>         /* last cacheline: 56 bytes */
> };
>=20
> If you want any other information or want me to test anything, I am more
> than happy to do so.
>=20
> Cheers,
> Nathan
>=20
> > > > > > >         643 | static_assert(offsetof(struct uverbs_attr_bundl=
e, attrs) =3D=3D
> sizeof(struct uverbs_attr_bundle_hdr),
> > > > > > >             |
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > >         644 |               "struct member likely outside of
> struct_group_tagged()");
> > > > > > >             |
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > >       include/linux/build_bug.h:77:50: note: expanded from ma=
cro
> 'static_assert'
> > > > > > >          77 | #define static_assert(expr, ...) __static_asser=
t(expr,
> ##__VA_ARGS__, #expr)
> > > > > > >             |
> ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > >       include/linux/build_bug.h:78:56: note: expanded from ma=
cro
> '__static_assert'
> > > > > > >          78 | #define __static_assert(expr, msg, ...) _Static=
_assert(expr,
> msg)
> > > > > > >             |                                                =
        ^~~~
> > > > > > >       7 warnings and 1 error generated.
> > > > > > >
> > > > > > >
> > > > > > > vim +643 include/rdma/uverbs_ioctl.h
> > > > > > >
> > > > > > >       630
> > > > > > >       631   struct uverbs_attr_bundle {
> > > > > > >       632           /* New members MUST be added within the
> struct_group() macro below. */
> > > > > > >       633           struct_group_tagged(uverbs_attr_bundle_hd=
r, hdr,
> > > > > > >       634                   struct ib_udata driver_udata;
> > > > > > >       635                   struct ib_udata ucore;
> > > > > > >       636                   struct ib_uverbs_file *ufile;
> > > > > > >       637                   struct ib_ucontext *context;
> > > > > > >       638                   struct ib_uobject *uobject;
> > > > > > >       639                   DECLARE_BITMAP(attr_present,
> UVERBS_API_ATTR_BKEY_LEN);
> > > > > > >       640           );
> > > > > > >       641           struct uverbs_attr attrs[];
> > > > > > >       642   };
> > > > > > >     > 643   static_assert(offsetof(struct uverbs_attr_bundle,=
 attrs) =3D=3D
> sizeof(struct uverbs_attr_bundle_hdr),
> > > > > > >       644                 "struct member likely outside of
> struct_group_tagged()");
> > > > > > >       645
> > > > > > >
> > > > > >
> > > >
> > > > Thanks
> > > > --
> > > > Gustavo
