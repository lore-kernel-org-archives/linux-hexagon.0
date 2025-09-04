Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82EB2F90E2;
	Thu,  4 Sep 2025 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756983135; cv=fail; b=avda6h7/l97GQZ50NR63UQYTZKfG6HEXTzW0pMW3QlH7OI5eUZqOs3hBAuW0ZLqCDwC+PEzcv3N5qjLobjP2cCa5Jcu58LvfiPo2NdiPsxOx9sYNueNSNJSSYECSBXRW25HllUxuqxMpggaQDbfRfD7k/TBdgyv0iwOvgvHHSRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756983135; c=relaxed/simple;
	bh=OoLZlHn+L6mDlUiDOZkUrLVjJ3NZT6beWHjMfZMzYLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P4hQRu2VeF1ue7FIatvtQf7AqnFZJCQrYqOSObaJ92/Eq0PBI543crkekCAyPUmUYIEG0kxhNyX0d3OAhPKDXsPRSJ65wN8VTLfY720cs12ZSbSbT83dT9X+NkX7OtKXpCJZifQUqa4S9Zf2SbW53zxWbCxXD4mzSE0sz70xY/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UiL9YBff; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vW33MP0G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UiL9YBff";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vW33MP0G"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584AOuF9002436;
	Thu, 4 Sep 2025 10:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OoLZlHn+L6mDlUiDOZ
	kUrLVjJ3NZT6beWHjMfZMzYLk=; b=UiL9YBfftRakUYKdG3bY8UGfBl01WlSi61
	rtU/lXWEwezlpT2q4YKMFSR7cfvEFzXdUeqy/7AecAs6G0L7l7zbTfYLNnLankZS
	Q3p8K8w3hY0F0Jr3tt//0l9VS4g5w96xGY3HQe3727a3nAVd2+VbpvJ5vYP+jz2L
	0f8Fs5Lh/B07TUJO69JNj7UWT4DGVt+To3kmzOIz4Tbs73gGn4OXJZFWKJ2tvTR1
	L97by6xdQcZxDW46B2R0DojGxlGOBU70hcMz1uTSBtlOiK5keGqM1A5CXDeWybsO
	BXrI9/UJhFIcWPEe0zXikQrnBhKu0YqrPoYq+KyMJ6BLXD1643HQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48y906817q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 10:52:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5848th3C040080;
	Thu, 4 Sep 2025 10:52:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrhgnf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 10:52:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbkn+EmOHf/jmnLOxMk4cRgSbm+muwR1zv4YAwmhz+N6GkT0Q3jeCNCAlgPMqFJOB1Sasd4pep1PtSlwmTcEd6Z1dt+7/9Ovk3sIXMu6vA32QY2kp4j9VVg+d2u33dqQziU2NtXVaFta46FOkfFJHzON1G33jV5XrPsa3ZQgCpwbvlUCkW7LGh0i3nz9T5XJpXzOkGIxy/Kv1TESjnoXg3FZB14lP9Rbc8yOgBNlmQlGrx0pky337f5AwtbC9Zc9V2f+lcZRH1dO+W5BUOq11hfJJrgGgMsB48PUIwYNQxX47kuQXjV4o9x5DwVba0LVR0g7B6Qb9BwsUVECz5cknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoLZlHn+L6mDlUiDOZkUrLVjJ3NZT6beWHjMfZMzYLk=;
 b=NwDQ1wChCuYA4+jUGL7Gpg1aVEsl2575IMvzX9QGCYy3RTj8tP2qUYiFhCelPzueS9C8lFQm3k59NHi8d44Rj3mvpnUAMmc1nfMvek+JDcshLBp9JQXEhZURJZWbi8OBlMYundft4vQub5KC0vZstNy+yC9puyljOCGXu0BG37x0ilzLVZEFMPSCC+GhkNEajs0aPZ8UDKsdjdy72HNBxMiuEvlSCPWpa1WzmplTt334RVrmXX6zGj24OWxSSEbPX7tR+AbyILN3vHoAmPirEfxPjF0q7Cm/dHZklMRoyOjI56K3h+M4edY4lwolfirpfEKlxp7SfBleoG83aqqC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoLZlHn+L6mDlUiDOZkUrLVjJ3NZT6beWHjMfZMzYLk=;
 b=vW33MP0Gx1MfUp9+IP671Ph7DY9qI/VRKM18m/EnMTVtnWHH5B4M051W338yekB+j+ltuJd/Soih/aDQf49Va4isqpa9qY+vqRlQ605Jl60MPFxnDctYHdUBIdrm6CVvGDuEMGbdsFwuhUX/q1UUBUolOXJDBZ6RoFyiqUpSoWU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4488.namprd10.prod.outlook.com (2603:10b6:510:35::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 10:52:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 10:52:02 +0000
Date: Thu, 4 Sep 2025 11:52:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-mm@kvack.org, Brian Cain <bcain@kernel.org>,
        Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 0/2] change "a mm_struct" to "an mm_struct" in comment
Message-ID: <3f5dff1c-06da-44dd-b5f6-053826152941@lucifer.local>
References: <cover.1756966290.git.joeypabalinas@gmail.com>
 <247f1fb3-6966-4789-8f26-7d4126318c5f@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247f1fb3-6966-4789-8f26-7d4126318c5f@lucifer.local>
X-ClientProxiedBy: LO6P123CA0044.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c61a95f-6796-4f6a-cea5-08ddeba114a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4poQiAuya41op5zDcZArYSOA+6usneqSE1L0tiMI8ZcXuLDoa4I1O5sbXxQ?=
 =?us-ascii?Q?T4A2Px4mXqOZCIzw+CqfQIsilAJV08JRHwteQgycmmyzhISWLhmfB73LpSWu?=
 =?us-ascii?Q?8hCvHJ94hWTxnx1/Sv3wTW8887WCNL59K1Q01am0EChvQcBpHj2VxAuLsk24?=
 =?us-ascii?Q?jNvHjbcMZHus2NPSPfjEqxrqTQGA0heV8ivBo+3rcn568mgzAWLpckJGwiCu?=
 =?us-ascii?Q?W+qjFF+cxNIpbMyVMQZpjvKfk74p7QO+T5XP6EeTQVAcDMbs+/sqodNDRfKT?=
 =?us-ascii?Q?KbBiZGu62HEG1/UNkySGM8IvMCg095l/kr1bL1av6DMs7Iaj8ts+bxCrtra8?=
 =?us-ascii?Q?vAoblWIoG9s+Ikaqn3Dw/EfVcPbsXGnMKL0Aqk5RW+GGk85ZvZNxpC07zRk5?=
 =?us-ascii?Q?4GL8yOj32NWnA6ZqCtnnYMn2D1sSo5Af/dh/XXF9frSfIaR9rEdXj36rNiAY?=
 =?us-ascii?Q?H4QcFqYA8xOYhORDUcZn04XhO0yT1zdO1KnHMAdnMygxPt9mLv7Lf6m/3opr?=
 =?us-ascii?Q?NEIyNZZY8+DLB8pNU8QYotCqFSnIWmB8cA3Pqh/seYY0rHs6tXI2haeDcH/a?=
 =?us-ascii?Q?5GlWA51dB7KZRVT3M0+n1r+wUKyKJfToxBBmZPkPl/gK/G4mK8HS5XMPJpiU?=
 =?us-ascii?Q?hv/Eh7gxgYgktth4uW7cHRjPSeTY2k9Dy1WZxQfLvPIQbWRbfrGkkvEG3Fo2?=
 =?us-ascii?Q?/mj+x67HRYPZ7a3kDdCqmchLr50WzUN2UhNkxtiOqLm9VbLgmOk21CcSL03x?=
 =?us-ascii?Q?9pJOpbyxG1atTFFRexLAjeSWKwPa5uTwNJ4qjhFclcShEzMWxUc50h9RnwBs?=
 =?us-ascii?Q?X96QVJnuHBRAfZpzrCc73bK0czSwcyr/L+hOIbZxlaMFRkK1oxG1UCR9s0kN?=
 =?us-ascii?Q?BpTeh/qeUNDueqSUu1eRot6X5GSCw8DztB1XbNUfEszXkFP8V4jID7ArxOnn?=
 =?us-ascii?Q?+Qtx4k0EDzEOXJ3Wb4hUGsIETLRHq3079tFkZcfgMCu80UhUtLZiCf8LjAaE?=
 =?us-ascii?Q?8OcVKmYWEJWa4EOeg5X6NbiQ0B5lBKzDq9KT7ECtMIW6wQVj4/Y5dRU5FDsn?=
 =?us-ascii?Q?EiIQsz/gKm5ckoe4NeIQQGoaWtsSKW3aXRSYX3gly3vOp2h/Kf9q5vjJU+v1?=
 =?us-ascii?Q?ux78KuJbQNZ/pjq9FDYz4ZarC010IsA40T5BZTPrTZ0B4yBEQYQf5oQqYOK1?=
 =?us-ascii?Q?EJw/lqBVKiXp3MSy0g6OyMKGGAYvMhkrPX5cKEY4GaAy2P2XHZBYUtBTQZLM?=
 =?us-ascii?Q?1TM5PiAC3EaygJTHN6027TkcfKX62qoWINrnkNdK7Vrz75GsTPtUMtGvaN7P?=
 =?us-ascii?Q?4Msq3L4PmD0z4NpXvs6os60kXOJd1F9AKM3IjpxDsAp1t+D85Qj5568l+ppV?=
 =?us-ascii?Q?+QFpEoZk1CTEl6FP4orGaXbVqHk9mUPWNPYa0ONuxGP88Qtpa1NWTxf/1OjK?=
 =?us-ascii?Q?6cjXhlfUCo0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v8NQRIK82sh2b05BbIoe0KeOGcIk13Q5ywjoSzzQ0Esa5xjBjFw2w7wsUPZj?=
 =?us-ascii?Q?EBl4+jeyWBnUap6ytJOmibA3b8qdnMUm8nBKI5eP/W/Cd1L3NHM0K9ZTm2rF?=
 =?us-ascii?Q?H8aV3zNxvTeCav2UsiKuIxsAMdnAzeJSzBsuryamliSt55LEClxZpYko9lay?=
 =?us-ascii?Q?xJpb60uNuY9rXf9j5eEyanTg9lnsRPwWKgOkWDXxCXhoRsOwwky0I+/YhIz/?=
 =?us-ascii?Q?6cMIl1E98gDR6hz9CJ8JDC4354g3txcTFqoGAfdmuSwFYV7z5zNyBbo5RiOj?=
 =?us-ascii?Q?bRtvEZ5KqHkmU1exWRsh8wTpxFBXcUj37iYJxf6A26KAj+ltJ59QGPAKJs3l?=
 =?us-ascii?Q?2VGJ8zCN8RwZVRPhpvsEX2Jjgsi2g55pERz6RzsBjrLWZajUmBE/3K9jjQVO?=
 =?us-ascii?Q?qIq5YRsbn4a7TpWzCjpYdM6wQ49VDnHpmh7XaEvOxdRste6TxN/BbNlsdm8i?=
 =?us-ascii?Q?6bfKFtluiJ+Y0yvv+QEzXvMtDSQfQHP0PZFnrepzL4UAqt/NbpqBgeNYBRIC?=
 =?us-ascii?Q?3EjybGKlP95ikuDP0XfXnkleBzwKartbzZX15fAbU0Zhprsy7rIhjIEfNfRp?=
 =?us-ascii?Q?p4zuMeRiLxUYEmX3vIxQ9wWNBQXD2oY8fhrrl55JAnReEYD06GBj8O2cr6ge?=
 =?us-ascii?Q?kug6Gq4NioIE5A7+0+bhePzIvlKv5au2vDA2W7+qhf1nQpI4A7BnjlgJhtK/?=
 =?us-ascii?Q?iIiudF4jFBFmDw0XPFpt6I8KiJCNbteWgs+uC3YpC1oKMkym9qZFwTIZ8Jd7?=
 =?us-ascii?Q?9xYeswtIQAY9XjGnqoLOXx+9RYc9hnKdHnSddkCINdLy2IlJInn7yMfwnmKT?=
 =?us-ascii?Q?bX7pwClypMg/LqirVEYuBthGSoRUpcPNlbIF6R4YzetDAzJimpWZFSOLRteC?=
 =?us-ascii?Q?JTs9KGMZo75TDIOBwZkueloPwXLKJV12oREljEvnlSFDGTx4rzXPfOntosAV?=
 =?us-ascii?Q?7EPlTCASoBfUpcR9X2Gui/tZfu70mqvEHX+k9275n21YET6SX97pbtE2dIV5?=
 =?us-ascii?Q?eCBpAUEevDBcnS4xT3VnmUvZt6s6fzGW9CWeyE3SBd52T+eoR97KSJveWutN?=
 =?us-ascii?Q?6vEuGxTnRlrUT5X8dLvh5tR9Xq2vXOrog1iXyg4Q994fgquuWXcYX+50UF4+?=
 =?us-ascii?Q?R3eEJqpKWdht2OUZJIsxGcPBsnWN2Py9UwD0ckz4QwyfBINVxCkCXK5+rvxt?=
 =?us-ascii?Q?wLs7s06bv9q6E9HqYsVkT1OJ8rkyW8fnMgOUVOR0RszmkXomZZ6DU2UZrff9?=
 =?us-ascii?Q?uHZr8fnRTTUMH/Jc75jEn/ai02cN2HxJ2hcHLlsEUgCVQtxgbOElewgDSB0O?=
 =?us-ascii?Q?+6Nw4GA/BlCjkKEO50bbbIixs9xMRMUT0Q7F6CjMA0v++6/5gBlD83HIBWPi?=
 =?us-ascii?Q?RrtNnLs8JhEptUl24F7QXEbLlf7MEM4qDdJptWICihPzvaivlh1p+33g2MPX?=
 =?us-ascii?Q?q+115yhnzY+jKUXx/4cVVYbaun0qH/pIgXb4wcI3HcBs4Vte08dIaYMjCWL1?=
 =?us-ascii?Q?aKQb4GkNjI9o0jjqime2ZQjQmfi4qeXLbuxQZT/SyaXBtQSw1ezofYhrcKFC?=
 =?us-ascii?Q?vMPPSFvZ6XxB9UC7pxaUzP3ZER2urJUYng6fkM7pLTz+VTHFbWnt6ev1+1DT?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tph8jDBjyVUQ5A3731xDpyOKBzVh4aPYiBztY9RSr2EG93Pw/T8Fmu5Xsoq7pFAE3CzwFzoMgXEo538DCKJ5hEiooA6OdnRCW1Y83Ez+2/6W7feUhU4jq2WWzh6TwgtDG+ldAEQGClwXdoFim7dYWcEwzHV46dRUNptI1CFN0x6IucsDJ1dMoMaEEO3DG1JwN32kAWtBMXZE1KQxtSbmpZceD0/or+NHBYwB//XvdvmQ6Y6a5kRdhHGCy6nHBsuoxYdsR6t3d2UZZJIPfOpcbBK6TArRFYSbP8O7cKS0oXph+pkSJzbiqM4qGk7br3yzzHENzmz9Aya5D74Swl2G5JssRp+mYtVEc0tY/3PwKhZwHsnYtcyRz611wpSVjVx4YnSaOmhS5IKD2AvGpWsBjaZ+iQcpa5L2ejbZIFtMU2mx26QwZpA8bOS4Z3u0/ZMUWPbdcWxQ1UnF/SPfeo43KnqEUsgSa/SXWNwpaBflD21FI60iXEV3OMZ5RVJ9dQ7o8D1cYxcFtQdsYfslebozD15ZTIkZv58elSzJxaUncq0R3wkyNhqcRpBKQ83uNgHPKL/Z+HhchoNyo97m3Cl8JlKUKqm9QWqG7AXRjJ5+Wpg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c61a95f-6796-4f6a-cea5-08ddeba114a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:52:02.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw3ro4bTcMcmHQK360mBQgPiGzI3q6C/IBJnfqhdd48HhOW0KTvFZSYWpk5ngrAa3jaWOzflXFtuNuG3rht7t26QmRoyVt/uw7dcx2XsgTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=603 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509040106
X-Authority-Analysis: v=2.4 cv=K+ciHzWI c=1 sm=1 tr=0 ts=68b96f55 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=U7oTKGeKxkZWjYXmyJsA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDEwMyBTYWx0ZWRfXxo5/CvKbWV6z
 6/TA93rj7mA0AIRO0XgcvA093rHuxN9tqhaTV16BiUbJyY4WvGKbxU0ubrveQgsmd2nG3DtE0Lv
 Dm7WC3fmR7sutYe6WU18pnAXoWI+jF/BupJGAShYKFmjVsqgw3pcoLQzxp/AN6ZoiDeNYaJKElJ
 eTIb82AlIOLlZnM61qyGd4rsn8a90HC59YTexGM/1j1t3FciHru5owpo4f4TPai+ppPkEuDL/vs
 1NsimvVOhMyNTLFVG2/fTTMIi/C/3IOVTiDZcGeGVjTVxNty7c3IUE1GiRVKsKsAHgHWnTYfgwt
 A9Fcv3oR0y1CT6SSrpo4bYqav/6r3XE6GtHOBaKlI+20BSDaOkOCDhvWRAhhMFVifxiLZTnb9xq
 yAcF7TP95GcU+Zq5Wg32BxB5hgJjtg==
X-Proofpoint-GUID: _P8oByh4CAu3Y1JGGAWLEOKxsQaRAnT2
X-Proofpoint-ORIG-GUID: _P8oByh4CAu3Y1JGGAWLEOKxsQaRAnT2

On Thu, Sep 04, 2025 at 11:46:52AM +0100, Lorenzo Stoakes wrote:
> isn't great RoI on the churcn here. It is also very silly to make this two

Oops typo - should be "isn't great RoI on the _churn_ here" :)
