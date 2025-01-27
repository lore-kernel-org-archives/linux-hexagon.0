Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D084039;
	Mon, 27 Jan 2025 16:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994940; cv=fail; b=VgmHJNUrjHK7DS+BOrzDjZYHO237RVvWSx3mq1zkvC+vsdp2xiS27PtLhxCWlDxJXbf8veFvyI95337vVI0dc0bPJ07rzV4R8II9sovsdFQuaSl2xJrrJOJhTdXFhitEHRwWbvbnShJk0/Y5gv174958QlnnAEafzhjGFEOjV08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994940; c=relaxed/simple;
	bh=8/h/04KqlkxrbrvuNUdRI91VppIjOHdXDE6sk+91hyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eyv/+v2CbffyFFEDr0p1kNlieoPGwLxDss3Rkc9EUCmjRTZY8AU4sPGNvhJGkYIs5hjnV5w/M735Al+vgdFxeW06T3Ck/05VS++IigUMXHFAMqyPB7I/gL8aKroXihAj+jr6/HAy6UYxaRH2kY9ZIKs+dCUuPabRK0ZAVJKXBZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cbWQKfJ5; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cbWQKfJ5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RB6opt011289;
	Mon, 27 Jan 2025 16:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8/h/04KqlkxrbrvuNUdRI91VppIjOHdXDE6sk+91hyY=; b=cbWQKfJ5VPT5xA49
	UgShUg3eevcjddewZSVX4s+0qlZadUOdncYEbzkKL8CQiWpVe65HnQdOGzvbWO6W
	lH1co0a/q3zDmfZamXVSGdWmxEry9k0e+INBgw5MPyCpaHBQ1F43qu7j8mYR/AG6
	IoSVTN/FzXmRsPSTtiIrsIiw0nMFMBIjluUfnU8VRpUdLqz/SASHqAeifYwuLnTs
	3v6KJfuKGK//nlAREMDtH5yVrvmorvh661VcSP87s/SupVOaDLYeVGgXrL+hdPqe
	44H6xtyPyKrMoFZwLH5yjUSFTmZd6xf/SubKJqf4useEIqq+KKoJNNb3J0scLL+O
	YsvL5g==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010007.outbound.protection.outlook.com [40.93.13.7])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44e9010qbb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 16:22:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McTqfsYUYAjfQ2DhX5Ga+I3cfVLhYKlnWq+cy5d0UNg7ALdZbtk6q0kTMcRP/OJd3bOhK08yPtISmiFNQPnyFpDEF0DGuumx8y1256Kw/IP4lUe+6sqAs2NDJ55DyZfZVurQ7qp8NzMcRGepZM2B/7tUlII0FfvJ1vuEosNW6AtNPJ+9pS2Z+/Yyz6Lu6FMTmsp0uP/t5rnVy9zBqHfa5ZeJ9sKZw53KGZIzuQpTONfnFTpfoOMrLe19pCUXK4Ill25u/83MxEXvHUlkN8j4ghTEK2ticXH9I+f3/Tro9zz0cGkXV0i1/yPBgDfkxMpLNLyvBKRisUZV4aoCcTLAbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/h/04KqlkxrbrvuNUdRI91VppIjOHdXDE6sk+91hyY=;
 b=iSKWU68GfA+JydyGxoTDrI9h+FQ/3tlLRfeUN6Z33UoViD9LpdzTnkrN87g8Egb5OC67SluM7BW9j/0g9e0u3Zb+knmqjyZ+7LiCifwZpwqqodK1G8LOh8ItK1Lhn1lYQxwBmbrAQU43bD+LgQE72MjZu8AzSwYQRpifnT25vHxtxO2LJ+Vp2EUW/t8gta6Gf614F1wqfEDbSMmQHm+io0zpapBB1SzenlZBNS9GgOKPPEfpGNKVNV6Jw3IOAkuveC4bt/5495ff793tq1i9YjTWVZqt3bRbhHNAyYn2Qu5qxog+u7e6TViCsp9pKBB7QH2uhahbC3OSd39d7WXFSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3SPRMB0001.namprd02.prod.outlook.com (2603:10b6:610:153::20)
 by IA1PR02MB8945.namprd02.prod.outlook.com (2603:10b6:208:3ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 16:21:59 +0000
Received: from CH3SPRMB0001.namprd02.prod.outlook.com
 ([fe80::1e96:7417:cf8f:8102]) by CH3SPRMB0001.namprd02.prod.outlook.com
 ([fe80::1e96:7417:cf8f:8102%6]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 16:21:57 +0000
From: Brian Cain <bcain@quicinc.com>
To: =?utf-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
        Christian Gmeiner
	<christian.gmeiner@gmail.com>,
        Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
CC: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel test
 robot <lkp@intel.com>
Subject: RE: [PATCH] hexagon: fix using plain integer as NULL pointer warning
 in cmpxchg
Thread-Topic: [PATCH] hexagon: fix using plain integer as NULL pointer warning
 in cmpxchg
Thread-Index: AQHbRdEuwe8aGW1/6kWWsaS+zsgY4rMLTvYAgB6xLQCAASNC4A==
Date: Mon, 27 Jan 2025 16:21:57 +0000
Message-ID:
 <CH3SPRMB0001A4CF7CD6E522DC45D5D9B8EC2@CH3SPRMB0001.namprd02.prod.outlook.com>
References: <20241203221736.282020-1-willemdebruijn.kernel@gmail.com>
 <CAH9NwWdODq0GXWJb_4jQNhgWjjAYfZccGLLLe7a=LVC95ew2tQ@mail.gmail.com>
 <b0504158-e9e2-4f00-8a9a-a653a6a0e313@igalia.com>
In-Reply-To: <b0504158-e9e2-4f00-8a9a-a653a6a0e313@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3SPRMB0001:EE_|IA1PR02MB8945:EE_
x-ms-office365-filtering-correlation-id: a11d449b-488b-4303-459a-08dd3eeeb84e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXZRSk9RSCtFT3MyZTVkSXdtRi9iMGQvT215Ky9OOTlwaW5lbHFjTWo3RFpT?=
 =?utf-8?B?aStzcldod3VPZ2NuTjM4MWlDKzBLZ1FiTjc3b05KSHVkTlRtVnQySHVIR0w1?=
 =?utf-8?B?bkFaK0p1aFhZckxWN1RJNGRNREYvMlFSTzBtV09TSk1NenNPNmNCNmhWVTFk?=
 =?utf-8?B?WlY5N3h5MnZrMnJpUzI2Q240aW5MVzZWNlN3UC9PY1N4Wmd3aW9ENElTb1FG?=
 =?utf-8?B?eWVkMDZ5VlNXL3FwbHljbHJpZThmdG5hUHh6cGcrWU5HMTduWGRPdFRkR1g0?=
 =?utf-8?B?a3dNb0FNVjkxVW13V3FQNUV2V0FFVzRWMHJVaTdnWWtQSWw3RGNpcFRJaWxD?=
 =?utf-8?B?Q3o5M05hVENxYWNYUkQxSHFKQXltb2p5Ui9NeFQyMXhoUGFxeHlJcC90Z214?=
 =?utf-8?B?UTQ4MjhHL3N5Rk93L0hBOGQvMXhzWlZMUEJBYWhJblp3Q0dhT1FPVEFsU1VU?=
 =?utf-8?B?TVhQb0JXb0pFS3JEM25GZnhtRzJQaXdEU2Jsb1E3M3JkaU5PdTFtcy9vVG5k?=
 =?utf-8?B?Znl6WCs2cEZvWmQrS1BmRzVLUUlhdmVqcFFqMnhIOUtGS3d2SXVaai9TVkJl?=
 =?utf-8?B?ekdpbjVmTHpLdGhMb1U2R3NjdmVYdXZibzlqR0JlMUZOdUZrRXBnUkpENUtx?=
 =?utf-8?B?MEtjcjJxTzNOVVl1MDNkdFBXN2djUVN4UXR3RjAvUnVGa1pCSmcrbHZqSm5B?=
 =?utf-8?B?d0Y1Y0s4akFJaDM2QktpVjVFWExKVjRGTGVnQk1pY1pBL3N4VXd6SzhoczdV?=
 =?utf-8?B?U0hoV1BqWGN1alhRQ1paRVZtTUJKVkhFQ2RFeWpQK2lyNkcrTEhkc0wrTnBQ?=
 =?utf-8?B?MGVRbkhPLzhxeUhHMUYydkFBUUJNRzNvZUpQTENJOEsrWUFXd2R1aCtMc2Vw?=
 =?utf-8?B?WnErQlQyRU4rTCtvWFl1ZkxUN05icmZrMHk5RU42VjhvWDZWVUJWaWM0R3BD?=
 =?utf-8?B?YkZ3QitpZnp2QTV1cHNjRWNPblRvK2NxM1FPY2IxM0VqR1Y1MEowSnBCb0pN?=
 =?utf-8?B?Q3hMWkJlVmViZC9LTEN6VFNHWEJtVGZhNExZSU9QUjZ3RnMrUUlFWFlTMGc5?=
 =?utf-8?B?d2RMVE9WVEd6a3JXOG1sZVFHZHcxdDhSTndnRllMWTY1cm5JUEQ4SUsvRVpl?=
 =?utf-8?B?NUxHWndmTDFlQkF5M3pROGNkQ3dDZ1JmZ3VoL1dLTHorYVRKV0JpRzF6UXdV?=
 =?utf-8?B?RVU1d3Jhb29nUUUwTU1yazlBQnZyVnMxT2UwbmRFenFqTkVXRHlnWEZad1gz?=
 =?utf-8?B?enRoMDlLa1dvQnpkM1dPYVM1b3ptWTdKMEJtN2M3S2FWWi9janRPbGhsaVBm?=
 =?utf-8?B?djNXLzkvd1Zjd2R3UThWNk8wb2VjTS9OSm1ENUVjRHlaWjJYZUxmVXBVZGc0?=
 =?utf-8?B?ajBUWmxURDdRVVZRemM3ODVURmN0TU5QaUU3bzN6bDVzL0orb1B1T0Y0MVA2?=
 =?utf-8?B?TEZVU1MxYnZSdlhJaEtPd3NsbmdRdzkxaTRWcVhWclVsY3JnTHhuNW1LT3BW?=
 =?utf-8?B?ZlJNS2JUeEl1Q0NyQlJRbVF5ZWFhL003b3pXTGdldG5TTzZDdE83NXd6c0lP?=
 =?utf-8?B?YWF4T2xWb0tnMXlTKzl6OGVyYmtsdENrN0NMbXRnUXlpbS9LV0dGZ1FuNzZi?=
 =?utf-8?B?M21DU1oyY1R4cHdJSHJxd01pTVBhTjQ2dTVGWGxoRnB4TXdGYnBMOTFRM2RT?=
 =?utf-8?B?MmdmT0hLcnZYcTJxR0VlZXh0eml5MThlemt5Z3dXUTJmMHdwOTNHNTVMT293?=
 =?utf-8?B?aitveGpOa2hBVkVQR25MWTBtNTZMdGp3dGlDWDRERDNyS2RBdTdsSEVoL1FT?=
 =?utf-8?B?cWJ2Zk5QZTZBUFhPdTZzOUZ4eUtzUHFtdjRaVFBEc29XVG16UGhteUNqUzdG?=
 =?utf-8?B?M09oUytScWRQcFM1Q3p6Q3Y1ZHZHQUcwTFRlejBZT09Lbk1JNVpJNXJ4SVAr?=
 =?utf-8?B?cXdBRGp4WUN6VDVUOEFReFBubHErRzR6cFcrcjZ2TWh2Y1k0N2NMdFdaaHcv?=
 =?utf-8?B?b1E4Rldia0lBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3SPRMB0001.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXVRei93QUFrS1FDQUFIZ1JWcjU4djR4RlJ1bEZGODlFUmpqNUs3d1QwMlVN?=
 =?utf-8?B?Rmd4NHUyOGkvLzVLV0lqc3UvMUdLMVRyU25vR1RudG9LbjhhQzk4VlpHUXpO?=
 =?utf-8?B?MjhWM0c2aGM2UzZFTFQxbzVTKzNFeHl2VXNhaEl1TEVBbnZUd3FhRW0rQjlI?=
 =?utf-8?B?US9nbUEvNnV4bFR1b3ZNenNzMHdPSElKZWlKS1RJSWh4WCttZWlvNy9McWxt?=
 =?utf-8?B?Nnd5S2RVV1A3c3RoWmZQSzV4OFRabXFRbURoK1RSRWZlVlJZZ3M4OTlDZXlZ?=
 =?utf-8?B?YUNUWk9ZUmhKTFJpdEMvMS9ZTnVJQWZWYTV3TlpvWDhxZEFoTTBOb0R6b1Fv?=
 =?utf-8?B?Z1NhVlNZWjZDclJTUmxOTlhyRHQ2V3FzLzVIZWNtbjJHUG0vQ1Rpb2FTZTJT?=
 =?utf-8?B?RCtaWkNKOHlyU0gxbmt4cmdtdWRsTGI2ajVZRTFKWWFTM05LVGlMeUdwNjZQ?=
 =?utf-8?B?N2xTK2hYQmxzOUZtbWQwMXNsSEhnU3AwR1c5bDZnUU9ROE95NDdaQzkwQU5p?=
 =?utf-8?B?T2hBRkVFdDRwZStFSWIrOXp2Y052RWE3Mm9wLy83UGxCZ25BbmJsR1l6dlA3?=
 =?utf-8?B?RXZDb0lFUUh1MjlPbDdGNlpMQlk2NVdwdmF0ZFk2TWN1THBrMVN4YUwzM0Ft?=
 =?utf-8?B?Vm50Q3owd1pOWU1qZjE0VVR3TkFGOEtlUEtuOGhkUE9tdE4xQWhwU2FCaDVT?=
 =?utf-8?B?TVR6SXJRSTNQQk5Lemd4bW1qT3VjRHM3N1JqZlU1QkE3bTJHMVJObmdsZGdx?=
 =?utf-8?B?dm9uYUJmVVhRdWxiK2V0aHdEUHJNTXlZb1JTWHZjWmwwNEh0dUNVQnhrclhL?=
 =?utf-8?B?RGRON3BXMk85YlBLWWtBZ3FIVCtpMU1UU21WU0lsQlBkYlV3S3BqdlVmOVNz?=
 =?utf-8?B?OEIrcFVmZURHbUJ3QVVTZXM3K0g1RFU5SG5Gek1PbC9RSmlJcy9LOWVjc2tX?=
 =?utf-8?B?N3hVVm1tMXp2RS9RcjA0QWhSNzBwdUwxSXlPWkRybXFrZW9Xd2hHMU12NEdN?=
 =?utf-8?B?aHY3RUN4MFl5QzJFRHM4aVFmVWJ4UE5OR0x1dVp5N2luUFhmakNDdlVlUjNo?=
 =?utf-8?B?VHhJZUx3Sk5pb3dLK2pCVFlkcllTeEtBVVVTbGVjcnRQWmFpZitZbUVGK1Z0?=
 =?utf-8?B?Vkd5YnhsOTBiZTdQdlZrdlJWMHQwWDQ3VkdGbzZkb2Y4dVZjcFRVb0phalh4?=
 =?utf-8?B?ZFFBTStvZG9aNm9EZm44NGN5cEZ0ZDFSYWZBSXhIQ3U3T1BQcHI0QlZEUGh0?=
 =?utf-8?B?bGh1NldIRFl0SUcrUklidktRRzF4dzRDK3ZDbngzOUFIUEdxN1hndkJwZ2Zu?=
 =?utf-8?B?c3duMGhTOG05b1c1Z1FTVnRXTVVKclpjZklVZ2tObFBuOWEzN0ZReXJSUG1S?=
 =?utf-8?B?eUsxOXNoTEdCNm1UTEhIR1E1cERlRHdOa213VGtLeGFETEp0MDBoRy9kU1Jv?=
 =?utf-8?B?UXdwOU1YTEFCeE9QOUs2eTEyOWRxUlVZVEFyM0hzeXhkRGg0NGpiNm10YmZD?=
 =?utf-8?B?NFo3c29oOTNJUGVHQW1GS1c0VHBnMXRUWDN0R1NtaC9qL3BjcUpyak4wME43?=
 =?utf-8?B?dWRMb0hGT0pJNXBFbGdUc1lVVFV5QjhFaWtiOTdBUmFJdEZDNlNOaFhBR285?=
 =?utf-8?B?dGtBMVlacWxkbUNRbkIyMWxlaWthalNyRExYVjFQbmZ2Y0dvdGpWUndFNE93?=
 =?utf-8?B?a1hZMUYxcTh5d1FHdDN3OGJKWUhxMlBnK251c3J1dGp3MGg0elNOSnF3QkdQ?=
 =?utf-8?B?aVBRQnZmRFhPck11NW9USVV1YXY5NE01WjE0NzVoOGdxbTNFWnBFQnhDT0VH?=
 =?utf-8?B?dS94SnIxY2ZMZGJKd0lkSWJUdWdMTGRFMGREam9BV1liMy9SL25ETzlTbE1q?=
 =?utf-8?B?VWFGMVZiWlk2c2Q3Z2gyL2VSaEpsV2tUSnlyQTNxQ2MxZ2NiNXFwbXdVTzRw?=
 =?utf-8?B?NVpjQkwzVTBNd0pSUjdGQnU4UEgwc051MzU0cUI1S2czRTZBWmV6eFBVRXNF?=
 =?utf-8?B?M0tadGdZblh1VFl3TVdFaDZzZVhKUjc3QnYvTVhIWU54SjB3ZmYvbkUxeDli?=
 =?utf-8?B?eFRGUnpCbXhoWDMvMW9xaWloVUtzWU1YTTQwSmtQQWVBaGQxZmFkaDdTWmJ1?=
 =?utf-8?Q?fxQ8=3D?=
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
	98LLDnOVlWG6AnpnKfIpJaT07zs+ZXMA6tdxpJo+SUMetn84oqI4Pjc1m39C0jq1JShJl126l7A0xFqNu4bTKYOmHyHtFhGnv4ewBgt8iF/6IyN4i6TsLbCSkAT6C1tHM+4jOf5jcU2Tny82QJE/GeAhso3I8KPapGJcp03BAmHaJmq/q1nGVXf13mJa8gKmsrKqpvSaemspqH9cP5wUPzdOr0cZeRUcew0JkdtIqAofE6DyHPJ5ZxXiDbSKtcCUcYvvLV8KixaBU+HCr0RVYAxlulaVm6yISN/xgLRdKQ2ASDcdJxi5L+elKMq/W6IZTy4PYeJ5ZwVGORfYGmBfj9VCz0NHWRzTA4Vqu2MmbFNibEnIAic5PCsj5UVGZuNkwjg02dOtx6t2hVwlfaxtNicjHkTN5lxcHEEfBcngMUdj59zFUGat88cGiQeplbbvEp8VezjkEWtVW7CCmQX+SeRIclNV4u0F8ORUrUHw1ggsuBZ6W4ldNcz/WQHkyWx1m8aTq2m7PSmvFHFEjPdEesrJcLRv8RZ9Tq57Xz1/ul6pKnblgUBZ7Xc6B4W+d9DHjEvPc5dsUvTMKmkIQUfI+kvcGaeW1onXz7cc82VurkfTm64IhqBltqQ/Zcb/IZIx
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3SPRMB0001.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11d449b-488b-4303-459a-08dd3eeeb84e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 16:21:57.1581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: afHYbl2W7V9qz5OEwavkqIk5oxAM5RqM8UdHTL7jpOW6/NzcVzGw/xcJ4hICVX6AMNpJn7X8v04ZRrcn7Jwd9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB8945
X-Proofpoint-GUID: tepVLT14qJBJzUCkV4y8H4km0vqbosBt
X-Proofpoint-ORIG-GUID: tepVLT14qJBJzUCkV4y8H4km0vqbosBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_08,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270130

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWHDrXJhIENhbmFsIDxt
Y2FuYWxAaWdhbGlhLmNvbT4NCj4gU2VudDogU3VuZGF5LCBKYW51YXJ5IDI2LCAyMDI1IDQ6NTkg
UE0NCj4gVG86IENocmlzdGlhbiBHbWVpbmVyIDxjaHJpc3RpYW4uZ21laW5lckBnbWFpbC5jb20+
OyBXaWxsZW0gZGUgQnJ1aWpuDQo+IDx3aWxsZW1kZWJydWlqbi5rZXJuZWxAZ21haWwuY29tPg0K
PiBDYzogbGludXgtaGV4YWdvbkB2Z2VyLmtlcm5lbC5vcmc7IEJyaWFuIENhaW4gPGJjYWluQHF1
aWNpbmMuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRob3dlbGxzQHJl
ZGhhdC5jb207IGVkdW1hemV0QGdvb2dsZS5jb207DQo+IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxl
bWJAZ29vZ2xlLmNvbT47IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPjsNCj4gbWNh
bmFsQGlnYWxpYS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaGV4YWdvbjogZml4IHVzaW5n
IHBsYWluIGludGVnZXIgYXMgTlVMTCBwb2ludGVyIHdhcm5pbmcNCj4gaW4gY21weGNoZw0KPiAN
Cj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29t
bS4gUGxlYXNlIGJlIHdhcnkgb2YNCj4gYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8g
bm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBIaSBCcmlhbiwNCj4gDQo+IERvIHlvdSBoYXZlIGFu
IGVzdGltYXRlIGZvciB3aGVuIHRoaXMgcGF0Y2ggd2lsbCBiZSBwaWNrZWQ/IFdlIGFyZQ0KPiBn
ZXR0aW5nIGJ1aWxkIHJlcG9ydHMgZnJvbSBIZXhhZ29uIGluIHRoZSBWM0QgR1BVIGRyaXZlciBb
MV0uDQoNClNvcnJ5IGZvciB0aGUgZGVsYXkuICBJIHdpbGwgd29yayBvbiBpdCB0aGlzIHdlZWss
IE1hw61yYS4NCg0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFs
bC8yMDI1MDEwMzEyNDYuQUQ4Smp6ZTAtbGtwQGludGVsLmNvbS8NCj4gDQo+IEJlc3QgUmVnYXJk
cywNCj4gLSBNYcOtcmENCj4gDQo+IE9uIDA3LzAxLzI1IDA3OjE3LCBDaHJpc3RpYW4gR21laW5l
ciB3cm90ZToNCj4gPiBIaSBXaWxsZW0sDQo+ID4NCj4gPj4NCj4gPj4gRnJvbTogV2lsbGVtIGRl
IEJydWlqbiA8d2lsbGVtYkBnb29nbGUuY29tPg0KPiA+Pg0KPiA+PiBTcGFyc2UgcmVwb3J0cw0K
PiA+Pg0KPiA+PiAgICAgIG5ldC9pcHY0L2luZXRfZGlhZy5jOjE1MTE6MTc6IHNwYXJzZTogc3Bh
cnNlOiBVc2luZyBwbGFpbiBpbnRlZ2VyIGFzIE5VTEwNCj4gcG9pbnRlcg0KPiA+Pg0KPiA+PiBE
dWUgdG8gdGhpcyBjb2RlIGNhbGxpbmcgY21weGNoZyBvbiBhIG5vbi1pbnRlZ2VyIHR5cGUNCj4g
Pj4gc3RydWN0IGluZXRfZGlhZ19oYW5kbGVyICoNCj4gPj4NCj4gPj4gICAgICByZXR1cm4gIWNt
cHhjaGcoKGNvbnN0IHN0cnVjdA0KPiBpbmV0X2RpYWdfaGFuZGxlcioqKSZpbmV0X2RpYWdfdGFi
bGVbdHlwZV0sDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIGgpID8gMCA6IC1FRVhJ
U1Q7DQo+ID4+DQo+ID4+IFdoaWxlIGhleGFnb24ncyBjbXB4Y2hnIGFzc2lnbnMgYW4gaW50ZWdl
ciB2YWx1ZSB0byBhIHZhcmlhYmxlIG9mIHRoaXMNCj4gPj4gdHlwZS4NCj4gPj4NCj4gPj4gICAg
ICBfX3R5cGVvZl9fKCoocHRyKSkgX19vbGR2YWwgPSAwOw0KPiA+Pg0KPiA+PiBVcGRhdGUgdGhp
cyBhc3NpZ25tZW50IHRvIGNhc3QgMCB0byB0aGUgY29ycmVjdCB0eXBlLg0KPiA+Pg0KPiA+PiBU
aGUgb3JpZ2luYWwgaXNzdWUgaXMgZWFzaWx5IHJlcHJvZHVjZWQgYXQgaGVhZCB3aXRoIHRoZSBi
ZWxvdyBibG9jaywNCj4gPj4gYW5kIGlzIGFic2VudCBhZnRlciB0aGlzIGNoYW5nZS4NCj4gPj4N
Cj4gPj4gICAgICBtYWtlIExMVk09MSBBUkNIPWhleGFnb24gZGVmY29uZmlnDQo+ID4+ICAgICAg
bWFrZSBDPTEgTExWTT0xIEFSQ0g9aGV4YWdvbiBuZXQvaXB2NC9pbmV0X2RpYWcubw0KPiA+Pg0K
PiA+PiBGaXhlczogOTlhNzBhYTA1MWQyICgiSGV4YWdvbjogQWRkIHByb2Nlc3NvciBhbmQgc3lz
dGVtIGhlYWRlcnMiKQ0KPiA+PiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBp
bnRlbC5jb20+DQo+ID4+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxk
LWFsbC8yMDI0MTEwOTE1MzguUEdTVHFVQmktDQo+IGxrcEBpbnRlbC5jb20vDQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4NCj4gPg0KPiA+
IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDI1MDEwMzEy
NDYuQUQ4Smp6ZTAtDQo+IGxrcEBpbnRlbC5jb20vDQo+ID4gVGVzdGVkLWJ5OiBDaHJpc3RpYW4g
R21laW5lciA8Y2dtZWluZXJAaWdhbGlhLmNvbT4NCj4gPg0KPiA+PiAtLS0NCj4gPj4gICBhcmNo
L2hleGFnb24vaW5jbHVkZS9hc20vY21weGNoZy5oIHwgMiArLQ0KPiA+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0
IGEvYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL2NtcHhjaGcuaA0KPiBiL2FyY2gvaGV4YWdvbi9p
bmNsdWRlL2FzbS9jbXB4Y2hnLmgNCj4gPj4gaW5kZXggYmY2Y2Y1NTc5Y2Y0Li45YzU4ZmI4MWY3
ZmQgMTAwNjQ0DQo+ID4+IC0tLSBhL2FyY2gvaGV4YWdvbi9pbmNsdWRlL2FzbS9jbXB4Y2hnLmgN
Cj4gPj4gKysrIGIvYXJjaC9oZXhhZ29uL2luY2x1ZGUvYXNtL2NtcHhjaGcuaA0KPiA+PiBAQCAt
NTYsNyArNTYsNyBAQCBfX2FyY2hfeGNoZyh1bnNpZ25lZCBsb25nIHgsIHZvbGF0aWxlIHZvaWQg
KnB0ciwgaW50DQo+IHNpemUpDQo+ID4+ICAgICAgICAgIF9fdHlwZW9mX18ocHRyKSBfX3B0ciA9
IChwdHIpOyAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+PiAgICAgICAgICBfX3R5cGVv
Zl9fKCoocHRyKSkgX19vbGQgPSAob2xkKTsgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPj4g
ICAgICAgICAgX190eXBlb2ZfXygqKHB0cikpIF9fbmV3ID0gKG5ldyk7ICAgICAgICAgICAgICAg
ICAgICAgICBcDQo+ID4+IC0gICAgICAgX190eXBlb2ZfXygqKHB0cikpIF9fb2xkdmFsID0gMDsg
ICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4+ICsgICAgICAgX190eXBlb2ZfXygqKHB0cikp
IF9fb2xkdmFsID0gKF9fdHlwZW9mX18oKihwdHIpKSkgMDsgICBcDQo+ID4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0K
PiA+PiAgICAgICAgICBhc20gdm9sYXRpbGUoICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwNCj4gPj4gICAgICAgICAgICAgICAgICAiMTogICAgICUwID0gbWVtd19s
b2NrZWQoJTEpO1xuIiAgICAgICAgICAgICAgICBcDQo+ID4+IC0tDQo+ID4+IDIuNDcuMC4zMzgu
ZzYwY2NhMTU4MTktZ29vZw0KPiA+Pg0KPiA+Pg0KPiA+DQo+ID4NCg0K
