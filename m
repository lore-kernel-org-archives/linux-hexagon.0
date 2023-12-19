Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E53B191;
	Tue, 19 Dec 2023 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OpFcNgS4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJKLtIN029576;
	Tue, 19 Dec 2023 21:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	qcppdkim1; bh=z11SkkTUDGIF83/qv3fXqEBjmJKqwjNw3ZgrsImeBOI=; b=Op
	FcNgS4UsNYmZUtecyM9JI+b32Ee7YL2aIsXJM3/n12mWYJJNAP8mIQPZBH2dka+h
	GvDq57ynv6ckwExRa1IjdA6rQyP0HbmRxgds90GOmVOawNFD2pvYyWdcOQD8XziB
	pX5LoLxmxvRQxaLJUOYfUMf9LljpGTvrmpYbItOQpL6xnlFBLBk3ng1G0i/y8V0d
	EVsFIUllehBmP/upg1YpX/mls/YdSszS0CmUZOZaurkyOta6kUvOm0WGloGWJETD
	HYQgUmu9CsLgzRCCR9bs/vAIov+BKK1LsYfQ5i5+u31YiJPCmQcLdXmTDHPQrqMs
	LafWiSf9e6iYStFsLk3w==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3fa3gh6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 21:12:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYKODTP7wX2ibPefbEqjL85vTOLw1mZvHvaAmJIoVPTjsM2l5vtO9RPjY0d7KHdwX6nbb/DLQcPjiyHrpUlPh9JAZ1hNsmFOPYBSmo6KYGUEiDggGPgyoEbK8ThRZPsJT3GFOEKOlQiFloyMvoEjMptpYYZoRAJW6eu/G76nrpXjpmYXONZK1ffBC006uT7NehT336mf7NtZzx1Zc7Hjy0eE619O38QicFsJbrB7RaivWHgfESrn8MxqtpcfMUwjfA/7qtq0H0FcclqZN2RLsO3EwKi58QvA2b/SpcPjk7uJS68fmdZXuK7zcjfVUx/L4TDE9osT6Pr2Ua77EKFh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z11SkkTUDGIF83/qv3fXqEBjmJKqwjNw3ZgrsImeBOI=;
 b=atbS18QjG7sACRSAZDy0amWgEpZEosHBBNXzOToyaLOEW3694gR6o8pmfHyGlQr8ooYxQX2OC6rr42jGTBSUpEHpOtR8ECzOoaidSq5FEWw69kqPP+lwfQtyo/Q/VaZV8I8IRJs/o/QFaUOEock4zfYYx83MYyvsdcSFMcoGSOtnIGzbfXHqsRCKsCOJ2afsT8tFULi0INCc1Z4FVtYeHuofBqOL/60ortRqF1C3N/Qi6ANrkbWh55x7RtgL9NtGahahxteIizhvllYuZzMHqcalFo+hAa82W13Su0v7d4AlPobP0xcdXvZno2gsA+ZyrC6Rl6MfZcQgQz8ahhmTAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by MN2PR02MB6686.namprd02.prod.outlook.com (2603:10b6:208:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 21:12:06 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 21:12:06 +0000
From: Brian Cain <bcain@quicinc.com>
To: Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<ndesaulniers@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        kernel test robot <lkp@intel.com>
CC: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Subject: RE: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eep...
Thread-Topic: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eep...
Thread-Index: AQHaMr4rpG0E0J8/iEqD3zuijWLkVbCxGIoAgAABXsA=
Date: Tue, 19 Dec 2023 21:12:05 +0000
Message-ID: 
 <SN6PR02MB4205511554F9177250DCEED0B897A@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <202312192107.wMIKiZWw-lkp@intel.com>
 <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X>
In-Reply-To: <20231219210454.GA540439@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|MN2PR02MB6686:EE_
x-ms-office365-filtering-correlation-id: 18f330c6-86a1-4203-7e3b-08dc00d72748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QGKROxS2eDYK+Lpy4DS44uRD4BFzBiKLmA9GgTDSLPT3g5aVNS99DwyV3CmWGfRFCZ+TkpaQcT66KQ+mjgj+0T5cLn4Yb99fV8AhmpOmCkyCppKgvMXQ23qDleoRoMOMUNG+brEFY+8CRAYBLvLg11HapsBEf/DoDeJkaN3blC3aF0U9H5ATcT5jx8qLzoJRoBZfXhb6dtQHD68ZA1PZYpgWGAnRH3usFJFtEEhzADxoBNLrwNR6FBF0nWY+8gVQvUmdFErURQCAh+041TvrLMrjkXhZQZaYfOhlvGenTVI6rJ20c+nxEfZ4565qlwHC4vgGGWaLS15bQtyTsj6mxQwcAbyranl8TfQ9GAnO9yR86RQZ/I5wpu03Xtrem3kgguLb74K3Hf/6cjctYSOBDRidjjjkyPLpIaTw3LeLSRF8TbcmJfr+7vn/S7ZeLQLU9QfUk+q7jO48DwKdDp988ITYgYDPmE8Gh531c5VzbrisRJemOutcYXUxG0OklSmz4RQE1t3Qc7egjMaXarCy7u7gpspE+SklhLvKH7tJdzSQNVD99InmME4p6d9lyE2b+sxA3OG9ldi0TYL7zl8IABcK0kDeKvDCbt2HuBI0/1mjHCQXANRqKz7fqijUNGXb8ihnViB3ZwrdmrMMJGe/QHhbxt/ZsUkthh+FOR+wkOk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799012)(55016003)(8676002)(8936002)(316002)(4326008)(26005)(478600001)(2906002)(966005)(52536014)(66946007)(64756008)(66476007)(66446008)(110136005)(66556008)(54906003)(71200400001)(76116006)(6506007)(7696005)(53546011)(9686003)(5660300002)(86362001)(83380400001)(122000001)(38100700002)(33656002)(38070700009)(41300700001)(219693005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YXB2bGJoNXk5SXliYWpueEM1N3dWdmNvN2lPOVM1dmQ4YkVhYkZJTVVJVi9S?=
 =?utf-8?B?NllZeFViOExqcHM4VUNtd0VJMXMrSkZTY2U2cDJFa2dRcWtRMU8xZ0V4TFBt?=
 =?utf-8?B?SFd0WDcyRXlXUWFzSzUrbE9rMEc1RlV1V1FOTGFTdzQ5c3JVelAvYnlHWmFP?=
 =?utf-8?B?ZW1HOG9EZ0lwNzRva1BiVGtWTFNJejhEbHhXQ29kUW1ieG9iaEJuTXB6ZjJW?=
 =?utf-8?B?U0V4TU1wSzNGVStrbFJYczVyL2tKYzNyZ0xyUXc1WUVhT2dsa2hPRGxubHRO?=
 =?utf-8?B?akRZNHhwZDBrMGpaSTJJaGJRUmhPUDdWZEhKbHA5bUhucWxPN2srazB6ZWpI?=
 =?utf-8?B?bjVmWC9oUEdMV0FscGZvdzhXa0ltZmY3RXV2OTE3QlBWRkVPUS9SeVpnYVNl?=
 =?utf-8?B?MFpPbzdVUTlTdU8ycUlLand5b3hVZU5WNXdDOW04YitKZ2pwTit0dnVqMDYx?=
 =?utf-8?B?b2NubkNUMng4cFRIZG1WZitNZFBoMUg0T0hjVkcyMjlSaTRXZ2NoOGdGVFJx?=
 =?utf-8?B?WExydzJWai9XaThNUE14VU5wVTJSLzAwVHJEbWh0VG5DNzArR2ZQVFEvL2xo?=
 =?utf-8?B?U09ETTFKSmovUDkybDFwSHhYT1lxNnE1ZjJKNis4L1RVMDQ1REMycE5sNFYx?=
 =?utf-8?B?MXBROVQvSXVtOTVHZFVhWFljZUU3bWNFRW41YTM0ZXBGbkZDcXZkUVljNVlx?=
 =?utf-8?B?WHZwelJSUU1CQ2ZPNDhWZVIxZ3BzRm5IODkxNGhYMjNyajFRaGE1bFJLOVBy?=
 =?utf-8?B?Syt0YzQwSWNVRmtQekt5LzJpajM2dDdoNHhGQWJuMWNpYm1PSXVLMWZhaXJl?=
 =?utf-8?B?Qi9vd0ErWHVmeDQzRmdMbjM1NWpXRUxnMWhpZFZOZXphTWcrK2R4QmZnMXE3?=
 =?utf-8?B?YWZKaDlLYldVTFkrVVRLMWw5cWY3cVdSNmZ1cUlhb2lzeERvN0N4RVpyUTRk?=
 =?utf-8?B?Tnp5Ry9DN2t6aG5iM1JzTzVLM1ZhQTFlbkQ1bW5RV0ZqQWZmR3lrenhxUkhZ?=
 =?utf-8?B?c2R2VzBHbzhBb2w3Unp4SjJmc2g4Yi9CdEd5T29Kd0VVanBJdGNqOC9Ld1lw?=
 =?utf-8?B?YXZoWk1RazZZNTdwK09Kd1IwT1pnSDBYU2tvWG1YL01UR1BLbFVyTzI2bnp0?=
 =?utf-8?B?R005Z0x3V1Y1RU5wQU0vd0pkaUtBb2NMcHlhVURGeEZmL2phOHlpU1J6d2NU?=
 =?utf-8?B?V1QwNzVIR0VEMnJGY3o4blVwZEhVQUFDR2djdytrVFdiM0lTM0NUMEl3b0pL?=
 =?utf-8?B?akY4NExYN0pqUXh6YlVvanBmd29wSGI3WTBhL0IyWjJYQmgrUlB3WDJTSTh5?=
 =?utf-8?B?Q2lOMDh0YUdzSVRpdStwdlA1L1V2UjcvWFNrdWJWai9TNFhKZHQxUUl0MEVh?=
 =?utf-8?B?Z0dnV3dHMnV6Szd1UlBQS3NZTjdjUFhRRW1uUjUxa2RDOXo5Y2c4U1FLa0VC?=
 =?utf-8?B?Y3RERmNtZ1JQb2VCeGU0alZvcld6cHV2SnE2NUZLS1JHS3YvOWVWSmdRY2lY?=
 =?utf-8?B?d1V0d3VtV2FGNUZkKzN0SzNZRHhKWHhaTVB1SGJwc0FyR2xncUZJVXgvcmJj?=
 =?utf-8?B?dFVKbkZhTzFMVXFTWXpOcE5xKzVubllBdFEzYTJ0aXVXbUhWb21icFh3M2dM?=
 =?utf-8?B?a1hPcW9mNktXWm1ZRHIyNEQ3c3gxU2JIRFJpL2ZTZUVnaDJ5YWVlNWwyR1Zs?=
 =?utf-8?B?V3RMcFlTRzF3VWhmWnozb0NLOWNscXNyVzBuYndkU0lYQlNHOTlnUUpGdGda?=
 =?utf-8?B?MmpZeWNoY1FvbGFzcmhBbEdRNWxSVDAwSFZDQnJSZ0NkR0xHdFEvWFl3YnNu?=
 =?utf-8?B?VjlUcG0yWjJQVDczRGlWS2xyeCtqZGZ2bllsSm5VaWxTQUU2L2ZSNUJsQzAx?=
 =?utf-8?B?UU5XZWNueXVjd085WGp2TWdMemcraThvQzEyMUNFTFVtT09McWVsWVFqRTE1?=
 =?utf-8?B?NGpWL3NGYmJWUFlLam1NeGRjYnc1SXRscFA1RlpqSExWZ1I3NkN4Yld6SWNz?=
 =?utf-8?B?TFhyWVlPNnN5bUJUcUE5VTdXUVRIR1hkNXdyQ1NUL1NWSEMvQlJ3VWVlM29Z?=
 =?utf-8?B?ZjhENENML3FWV3lhWTZFTm5vR2FzeDlTL0kvQTgwMnlUbXBtdlBtVHdqUHFr?=
 =?utf-8?Q?fSV4=3D?=
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
	QIvu6lxeMA/3eEk29ifEZc2+tdGlcHN5ayJMMpCfWE3YuT7zinUuBvUCj8nbzJV2B/oZNuadUEXiqunkkpSWYrkiCN4JYPKlXesggsa6Ka38JeP8HDDUJ4BVplk8HXnIcgZlwXdVup7UZE3s3Z1U25YMx4voc6fM8BsgZ4vgnfxB5IhlTR6Jj9crWzO2Cg2Wws7tbUt6hgdhQVA85ILzbRUBIG2FIIXWZdvUe3ErKORFBUT0gTWWIoun8ro4Sj8oPOpdzCO43w5tdc2AWa5jfB9wPVcU3Xhz7zPq9uXE/vqn8qo2ugdnlbNeNCi6/W7NUvelEHRF0IiQ/lUI7YQR3r58bpch4RkHyFB00KSjZ+Ww4UkeCTu0aJPZ0JfVzYeW6qPsvTHTvIYsNJWkVxfaydkMO882XZJ0dEl+aLf9dKG7KbASkijoXCIdOzwEwf7R1IyT8wwrXsDE0e3G7aYGMhjgonqzjQEzAISd18j0FjkiZn6runI8HUtDhstm6F01VvAPd47w8IBwygyz5LbdQ0Hy60OAtzPRv7G0ckndrl4uVynLnItiIlegwEcHeVE4qOKFJvLDd2x4olQqz4WkEdYI2SyDyFJ6EyxJUs0mL2yNUPVPEH0ln8L2gUuBKBqb
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f330c6-86a1-4203-7e3b-08dc00d72748
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 21:12:05.6649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g2RAuuqAET/lqnNoc5R3krm7fmcl4zSI52rZPN4IqExV2UZ4rBsFFvXS8xjaTwS75CgMF8POFHStf3SMecGMZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6686
X-Proofpoint-GUID: 27eG7Rn28QJHxiuNQwxq69Ck149sHARW
X-Proofpoint-ORIG-GUID: 27eG7Rn28QJHxiuNQwxq69Ck149sHARW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190157

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmF0aGFuIENoYW5jZWxs
b3IgPG5hdGhhbkBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxOSwgMjAy
MyAzOjA1IFBNDQo+IFRvOiBOaWNrIERlc2F1bG5pZXJzIDxuZGVzYXVsbmllcnNAZ29vZ2xlLmNv
bT47IEtlbnQgT3ZlcnN0cmVldA0KPiA8a2VudC5vdmVyc3RyZWV0QGxpbnV4LmRldj47IGtlcm5l
bCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBDYzogbGx2bUBsaXN0cy5saW51eC5kZXY7
IG9lLWtidWlsZC1hbGxAbGlzdHMubGludXguZGV2OyBCcmlhbiBDYWluDQo+IDxiY2FpbkBxdWlj
aW5jLmNvbT47IGxpbnV4LWhleGFnb25Admdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
YmNhY2hlZnM6aGVhZGVyX2NsZWFudXAgMjEvNTFdIC9iaW4vYmFzaDogbGluZSAxOiAxOTQyMA0K
PiBTZWdtZW50YXRpb24gZmF1bHQgTExWTV9PQkpDT1BZPSJsbHZtLW9iamNvcHkiIHBhaG9sZSAt
SiAtLWJ0Zl9nZW5fZmxvYXRzIC1qDQo+IC0tbGFuZ19leGNsdWRlPXJ1c3QgLS1za2lwX2VuY29k
aW5nX2J0Zl9pbmNvbnNpc3RlbnRfcHJvdG8gLS0NCj4gYnRmX2dlbl9vcHRpbWl6ZWQgLS1idGZf
YmFzZSB2bWxpbnV4IGRyaXZlcnMvbWlzYy9lZXAuLi4NCj4gDQo+IFdBUk5JTkc6IFRoaXMgZW1h
aWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9m
DQo+IGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0K
PiANCj4gT24gVHVlLCBEZWMgMTksIDIwMjMgYXQgMTI6NTg6MjhQTSAtMDgwMCwgTmljayBEZXNh
dWxuaWVycyB3cm90ZToNCj4gPiBPbiBUdWUsIERlYyAxOSwgMjAyMyBhdCAxMjo1NOKAr1BNIEtl
bnQgT3ZlcnN0cmVldA0KPiA+IDxrZW50Lm92ZXJzdHJlZXRAbGludXguZGV2PiB3cm90ZToNCj4g
PiA+DQo+ID4gPiBPbiBUdWUsIERlYyAxOSwgMjAyMyBhdCAwOTo0MDowOVBNICswODAwLCBrZXJu
ZWwgdGVzdCByb2JvdCB3cm90ZToNCj4gPiA+ID4gdHJlZTogICBodHRwczovL2V2aWxwaWVwaXJh
dGUub3JnL2dpdC9iY2FjaGVmcy5naXQgaGVhZGVyX2NsZWFudXANCj4gPiA+ID4gaGVhZDogICA4
OTE4OGZjZWI3YTQ5ZTNjNGIwNTc4ZDg2ZjZmNmU2NDdmMjAyODIxDQo+ID4gPiA+IGNvbW1pdDog
MWRiNjE3NDBhZWI3ZDZiMWM3YmZiMmE5ODcwOGE2NWE2Njc5ZDA2OCBbMjEvNTFdDQo+IGxvY2tp
bmcvc2VxbG9jazogU3BsaXQgb3V0IHNlcWxvY2tfdHlwZXMuaA0KPiA+ID4gPiBjb25maWc6IGhl
eGFnb24tcmFuZGNvbmZpZy1yMDA1LTIwMjIwOTEzDQo+IChodHRwczovL2Rvd25sb2FkLjAxLm9y
Zy8wZGF5LQ0KPiBjaS9hcmNoaXZlLzIwMjMxMjE5LzIwMjMxMjE5MjEwNy53TUlLaVpXdy1sa3BA
aW50ZWwuY29tL2NvbmZpZykNCj4gPiA+ID4gY29tcGlsZXI6IGNsYW5nIHZlcnNpb24gMTYuMC40
IChodHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2plY3QuZ2l0DQo+IGFlNDIxOTZiYzQ5
M2ZmZTg3N2E3ZTNkZmY4YmUzMjAzNWRlYTRkMDcpDQo+ID4gPiA+IHJlcHJvZHVjZSAodGhpcyBp
cyBhIFc9MSBidWlsZCk6IChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LQ0KPiBjaS9hcmNo
aXZlLzIwMjMxMjE5LzIwMjMxMjE5MjEwNy53TUlLaVpXdy1sa3BAaW50ZWwuY29tL3JlcHJvZHVj
ZSkNCj4gPiA+ID4NCj4gPiA+ID4gSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBw
YXRjaC9jb21taXQgKGkuZS4gbm90IGp1c3QgYSBuZXcgdmVyc2lvbg0KPiBvZg0KPiA+ID4gPiB0
aGUgc2FtZSBwYXRjaC9jb21taXQpLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWdzDQo+ID4gPiA+
IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiA+ID4g
PiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2Uta2J1aWxkLWFsbC8yMDIzMTIx
OTIxMDcud01JS2laV3ctDQo+IGxrcEBpbnRlbC5jb20vDQo+ID4gPiA+DQo+ID4gPiA+IEFsbCBl
cnJvcnMgKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gPiA+ID4NCj4gPiA+ID4gICAgZGll
X19wcm9jZXNzX3VuaXQ6IERXX1RBR19tZW1iZXIgKDB4ZCkgQCA8MHhjNjg5PiBub3QgaGFuZGxl
ZCENCj4gPiA+ID4gICAgZGllX19wcm9jZXNzX3VuaXQ6IHRhZyBub3Qgc3VwcG9ydGVkIDB4ZCAo
bWVtYmVyKSENCj4gPiA+ID4gICAgZGllX19wcm9jZXNzX2Z1bmN0aW9uOiBEV19UQUdfY29tcGls
ZV91bml0ICgweDExKSBAIDwweGM2OTc+IG5vdA0KPiBoYW5kbGVkIQ0KPiA+ID4gPiAgICBkaWVf
X3Byb2Nlc3NfZnVuY3Rpb246IHRhZyBub3Qgc3VwcG9ydGVkIDB4MTEgKGNvbXBpbGVfdW5pdCkh
DQo+ID4gPiA+ICAgIGRpZV9fcHJvY2Vzc19mdW5jdGlvbjogRFdfVEFHX21lbWJlciAoMHhkKSBA
IDwweGM2ZGI+IG5vdA0KPiBoYW5kbGVkIQ0KPiA+ID4gPiAgICBkaWVfX3Byb2Nlc3NfZnVuY3Rp
b246IERXX1RBR19jb21waWxlX3VuaXQgKDB4MTEpIEAgPDB4YzZlNT4gbm90DQo+IGhhbmRsZWQh
DQo+ID4gPiA+ICAgIGRpZV9fcHJvY2Vzc19jbGFzczogRFdfVEFHX2NvbXBpbGVfdW5pdCAoMHgx
MSkgQCA8MHhjNzc4PiBub3QNCj4gaGFuZGxlZCENCj4gPiA+ID4gICAgbmFtZXNwYWNlX19yZWNv
ZGVfZHdhcmZfdHlwZXM6IGNvdWxkbid0IGZpbmQgMHhjNjg5IHR5cGUgZm9yIDB4YzY2Yg0KPiAo
bWVtYmVyKSENCj4gPiA+ID4gICAgbmFtZXNwYWNlX19yZWNvZGVfZHdhcmZfdHlwZXM6IGNvdWxk
bid0IGZpbmQgMHhjNjM4IHR5cGUgZm9yIDB4YzY3NA0KPiAobWVtYmVyKSENCj4gPiA+ID4gICAg
bmFtZXNwYWNlX19yZWNvZGVfZHdhcmZfdHlwZXM6IGNvdWxkbid0IGZpbmQgMHhjNjM4IHR5cGUg
Zm9yIDB4YzY3ZQ0KPiAobWVtYmVyKSENCj4gPiA+ID4gPj4gL2Jpbi9iYXNoOiBsaW5lIDE6IDE5
NDIwIFNlZ21lbnRhdGlvbiBmYXVsdCAgICAgIExMVk1fT0JKQ09QWT0ibGx2bS0NCj4gb2JqY29w
eSIgcGFob2xlIC1KIC0tYnRmX2dlbl9mbG9hdHMgLWogLS1sYW5nX2V4Y2x1ZGU9cnVzdCAtLQ0K
PiBza2lwX2VuY29kaW5nX2J0Zl9pbmNvbnNpc3RlbnRfcHJvdG8gLS1idGZfZ2VuX29wdGltaXpl
ZCAtLWJ0Zl9iYXNlIHZtbGludXgNCj4gZHJpdmVycy9taXNjL2VlcHJvbS9hdDI0LmtvDQo+ID4g
Pg0KPiA+ID4gTm90IHN1cmUgaG93IGxpa2VseSBhIGhlYWRlciBjbGVhbnVwIGlzIHRvIGNhdXNl
IGEgc2VnZmF1bHQgaW4NCj4gPiA+IGxsdm0tb2JqY29weSBhbmQgSSBkb24ndCBoYXZlIHRoZSB0
b29sY2hhaW4gdG8gcmVwcm8gdGhpcyAtIGNvdWxkDQo+ID4gPiBoZXhhZ29uIHBlb3BsZSB0YWtl
IGEgbG9vaz8NCj4gDQo+IEZvciB3aGF0IGl0J3Mgd29ydGggaW4gY2FzZSB5b3Ugd2VyZSBub3Qg
YXdhcmUsIEkgcHJvdmlkZSBjb3BpZXMgb2YgTExWTQ0KPiBvbiBrZXJuZWwub3JnIHRoYXQgY2Fu
IGJlIGluc3RhbGxlZCBpbiBzb21lIHByZWZpeCBhbmQgaW52b2tlZCB3aXRoDQo+IExMVk09PHBy
ZWZpeD4vYmluLywgd2hpY2ggY2FuIG1ha2UgcmVwcm9kdWNpbmcgcmVwb3J0cyBzdWNoIGFzIHRo
ZXNlDQo+IHJlbGF0aXZlbHkgZWFzeS4NCj4gDQo+IGh0dHBzOi8vbWlycm9ycy5lZGdlLmtlcm5l
bC5vcmcvcHViL3Rvb2xzL2xsdm0vDQo+IA0KPiA+IElzIGl0IGEgc2VnZmF1bHQgaW4gbGx2bS1v
Ympjb3B5LCBvciBwYWhvbGU/DQo+IA0KPiBTaG91bGQgYmUgcGFob2xlLiBJIGhhdmUgbm90IGJl
ZW4gYWJsZSB0byByZXByb2R1Y2UgdGhlc2UgY3Jhc2hlcyBpbg0KPiBwYWhvbGUgdjEuMjUgaW4g
dGhlIHBhc3Qgd2hlbiB0aGV5IGNvbWUgdXAgZXZlcnkgc28gb2Z0ZW4uIDBkYXkgZm9sa3MsDQoN
CklzIHBhaG9sZSBzdHJpY3RseSBhcmNoaXRlY3R1cmUgaW5kZXBlbmRlbnQgKHVzaW5nIG9ubHkg
RUxGL0RXQVJGIGluZm8pPyAgT3IgY291bGQgd2UgbmVlZCB0byBjb250cmlidXRlIHNvbWV0aGlu
ZyBmb3IgaGV4YWdvbiBpbiBvcmRlciB0byBtYWtlIHRoaXMgc3VjY2VlZD8NCg0KPiB3aGF0IHZl
cnNpb24gb2YgcGFob2xlIGFyZSB5b3UgdGVzdGluZyB3aXRoPw0KPiANCj4gQ2hlZXJzLA0KPiBO
YXRoYW4NCg==
