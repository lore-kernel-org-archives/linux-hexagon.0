Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649D7168D9
	for <linux-hexagon@vger.kernel.org>; Wed, 20 Dec 2023 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dmqjpDo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703057376; x=1734593376;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=czOIIBk9i93k48Z2s9BSUSeQx9qgeWz2MV577rFIRTU=;
  b=dmqjpDo8roOK0bMmCc29XpuBuNoHy9Q2Rf3cytTjz4SwWb5Y/h6iAvAU
   wJYqLaaJAMJXTgPh+oAHCWZUgaoTDPeXqxXwdGmZWbZcg5C5z/soJSg6l
   I0GNL2oEdw7SqpVMSyNj1blPI6iPvf73eMGL86wqsGCzKDhmhltjHwyK4
   89vGols96pfHJuIWnAldu58YlcoWvaPpw0QzGBcMkSPKD9mRV45A5EgCH
   gBpKsAMUByAmb7cJWpb2xWG2E8td0h2i1YTvJ0e6J5diSLIUdHmYMjw1V
   ic7gX2jBkjbWq8UCNgfV7XtO5SMKPCxMw0FK8yUyvYcRbBKnxvB7KngvN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460117754"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="460117754"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 23:29:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779758726"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="779758726"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2023 23:29:33 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 23:29:33 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 23:29:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Dec 2023 23:29:33 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Dec 2023 23:29:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIbcr5xvj9skL3nfxpOBKW5OizsBN0JFSzb7zfd8Kbd5bSdnnmYrCTo25/mhn+HIgeZYxG2rFN8pAK3ZHFS97drSsL2ME9rx2gCwDpHUEcPSCF1zTRX/Toekprf45DZDzwAIzrwOsiwk7ODUWmNlUBlh1GKoJnGapyG8Qjf9zwI+s3V7jOY+czeBspi9D/+Ist/9bj6YHlp0/3MbSABJTiEydrNCfBOAArOg7A7/9z1dxapqi91tHUOMv3xr1SfkztewrLBgbeiOQPIbS9KX7WQKX1EDzQiZvjb1wCwnabpj1n2tGZ4ua6tSFBPUSDz5JsGQ4ptngcFdn1fbk2vw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYlEnr983boL8ca8bTTrD41m6H6X4SmQT89ptcBHKWs=;
 b=XLe+aV1yr3ZbyXp8YUH3Z4ISRnfgWeHkaTeaYC3FDq4aR1nE4J8ykii7MUPCkVjQi2erHrvKLm1iMugwhJ+kOBjOdHlcIB3t3foA7Q0YFcSG57pOLn/hE0pKug324pS0eZNcmZydPY60udjxCGSsQYz28HNgzG7GIPaLHhN0NCiIgJ8J8Ke0elTPmgoYRmKcmOaMInEPhlAOG75EhElSnreC1jYX/0Nxq/wO+2CymAbUpdkN7MOokX+d2rJpkmfrzRt4eTqp+oTA9LWw49m/7kQGg45vU3QsUK9WskM2Lw6BJRNmv4Bt0nnwXkxhGiH7Gs6EgMFjf8BI25kDKuvTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by BL1PR11MB5272.namprd11.prod.outlook.com (2603:10b6:208:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 07:29:29 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 07:29:29 +0000
Date: Wed, 20 Dec 2023 15:24:54 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Nick Desaulniers <ndesaulniers@google.com>, Kent Overstreet
	<kent.overstreet@linux.dev>, kernel test robot <lkp@intel.com>,
	<llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>, Brian Cain
	<bcain@quicinc.com>, <linux-hexagon@vger.kernel.org>
Subject: Re: [bcachefs:header_cleanup 21/51] /bin/bash: line 1: 19420
 Segmentation fault LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j
 --lang_exclude=rust --skip_encoding_btf_inconsistent_proto
 --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
Message-ID: <ZYKWxl9oQXODIoNe@yujie-X299>
References: <202312192107.wMIKiZWw-lkp@intel.com>
 <20231219205348.wvvxyicaatmljxm2@moria.home.lan>
 <CAKwvOdmrvwdbFrtzsOjoLJJZ1pDZOBWBiEb=Mx5bCHuKU2wPzQ@mail.gmail.com>
 <20231219210454.GA540439@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231219210454.GA540439@dev-arch.thelio-3990X>
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|BL1PR11MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: 5402a277-d620-4b98-a0a5-08dc012d66de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yiKi+iN8BWb51BJrzU9MQX4JZma+eyFDlzZjKw9Xr9pAMMBypCZWGceNqjTqS09j8DkEeDITPWREdSyZzi+SETwofiVEp98Q6tlNUojHLzervBU9wWJDUytWKPwCIskC1F7gqbW0ojXWOVy3XM391hB+pemmtxQFDZW8WU+CEOpQDy0aeXsX/aUMQaKpX4Y+XN3q3q9/v1RD8DpdSeOKWq3y7Zcj3INvAILH52G64Alhw988uIfHZGDbIR7XK5usK5bOw3ViZhYfur19KhF7uw28dwVPGUKqRboGb2iYKalJIniHtF39L9jVmv8RoJUbTp+nzCOZ2QrBwblENHsr7wAYFfHP7LmczZBgavM828fYm8ohjTu3ZjiZN24NXmulATm1QflnTeV0wFF63OCq/36ajEr0psZzVkvJpOJ0UrRsiL5RXgOxCx/wwLjllH4Fk+6qYsDnd5epiVQG6iVbOHTXWrL9cVnaNe+j5p/ZQB3bxWouVLdZ/kV1XFD9zg20Mygg17mqJDkQDsT4eoX30xUkOsbEMFdnT3s6ip5er5QkK5bLveaDidd6holan1bfvZ9LX61RB64EFkvTy5WZ8X5r7fvtV3J4r3UNFM2IXfmJ+TjZM5NAvLAm+MSqcW0l/j298vMpsOqM1zGkG02zIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(33716001)(82960400001)(38100700002)(9686003)(66476007)(66946007)(66556008)(6916009)(54906003)(966005)(316002)(8676002)(6486002)(44832011)(53546011)(8936002)(83380400001)(2906002)(4326008)(6506007)(478600001)(6666004)(26005)(5660300002)(86362001)(6512007)(41300700001)(219693005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVONm5qWHMwcEJqZmFUUTg1aGtSTEdyTWhBQ3F3MHVjaXhNU05ORFQza0Z0?=
 =?utf-8?B?S3VJTnZvVSt1SGgyMVo0elNBWnFOZTk3TlNmUnN2ZzZuSkZveTRlYXExaS9j?=
 =?utf-8?B?dURTUGZIK1psYnZ0WkVGWVBLbGw0eUxBaXR0UE43VGdMRm1Jc0s1NGZ2UW9i?=
 =?utf-8?B?L0ZUVzgrRWlxUytYTHBac3A2bnJ0RDZkWXMvUWlQbGJkdnRGeWJkQjNtd21r?=
 =?utf-8?B?STR1aEl6MUJXRklCOHJQbXBqWXRXYlNJUEd2VEovU3QrWnREb1FkQW95bGJu?=
 =?utf-8?B?NFVUNHdmMnlrMmdLTTA1NVEvLzU2Zk9OclJmZVBEMlFYK1NwdmxwU2hIbkZO?=
 =?utf-8?B?ZE5RVjFsSm90ZjgvbW5tT1YxMHNtQzFTalRrWTc3U0dtM3RXMVBGNUk4KzR1?=
 =?utf-8?B?cndxdmd4Rk9lV3U1STRLODRlWkJibU9DejhlUUozOGhkS3dzUTdPbEdqRHpj?=
 =?utf-8?B?WHM0UDdScmtLK1lOZFgzUEF1QXZNVElUZXVST0hreXBMdmJyK0hOOWpkbDNY?=
 =?utf-8?B?cmdkcEZRYUVGaE9VaXRzYzhUVENjM0dHYmxkNkxtbGMzdWhsYkR4QlhmZ0Q5?=
 =?utf-8?B?Ym10cHFLRURpRG4rbkpvR05Ra2RRc0JOU2x4Z24xNkQwdnIzRXBucXdoNWpu?=
 =?utf-8?B?QXcrRVZkZ1p1alBvYjdKUkIxY24za25lblRRYTQrZzA3U0NZL215OXdvTlh4?=
 =?utf-8?B?OXpRRGtIbDI5Ty90OWNvUFoyZHpmLzk5QllscjE2aWxFYm9FWUJSYThRcXVM?=
 =?utf-8?B?aHpLMU03WEZFdzZWK1V3Sk1Ca2RDaUZGRnhXRitWREFORUF0VTZWdmVPS0kw?=
 =?utf-8?B?VHRndU9BN3dTaXVzV2VGSlp6c243eGtHaWtGQmFOMVJlamk0dEVsSnFjWHJq?=
 =?utf-8?B?RzJ0STA1d1ZlZ3F2UEV2bXN0ZjBKOHFXdFlOYms4Q0tjamtnZHRkUTQ3ZEo0?=
 =?utf-8?B?WnUrbTFwNFA2dmVvZEM1dURIdkU0ekNkOGdFbHRyR3laQkZDUEdCZyttOTQ5?=
 =?utf-8?B?RmJlQnU3b2FjMEFKNnJvRDFBeFFoVmR3S0lERzYvNEdkb0F3WUwyMU1pUVpt?=
 =?utf-8?B?MHFhWWhVR1hiZmVBSlJieTJya1FLOFIrVXBONjM2NkZnUHVGU0lBcEhNMUI5?=
 =?utf-8?B?NUVVRWlBUklWckI1MFRoODlzUFdWU0pKUTlSTGtGSS9MdGE0bFppWXlKT1lj?=
 =?utf-8?B?U3p6OVpiUk0zR1pmK3dNKzUySzNvSUxLa0Q3TGRHaWQzRUMydDB4SmpCa2Jv?=
 =?utf-8?B?QXhOS1liWmhMbk9vaUxDRWNjTGl6VmNYbHFTckJ5NEdtMk5tOWdwN285MUN5?=
 =?utf-8?B?c3ltbVBXaWU4TjFkUlZmMExMUmpMRkFLdmMyM1hIN2hQUnJIZkZMZmRZQUFJ?=
 =?utf-8?B?UmY3VVppaC9NQlloRTl1dmVtd0ZEUk5uNGV0Z1VFUDMxVDd4THord0x4bUhy?=
 =?utf-8?B?M1hjTHBSaVBtMHJJMDFadExzNWhhSmU1RWNqbm5QeG9rSGVoa2VYRlArRHdG?=
 =?utf-8?B?L3NaN09laHU0RnBYazJEUUYyWDY1eEdHZW9oZFNaQjNGMUROc1lLZGhqZmFE?=
 =?utf-8?B?amxXbS9IYW1tbFBVakh4SjJBOWFrSmhWTjZsRXlPeExDTlpZOHg0TDEvRGRs?=
 =?utf-8?B?bWhEb1pFdUpTVTYrS3pUd1MyemhNSkdzOEVsQVZDL2cwTkdQV28yczlnczNv?=
 =?utf-8?B?bFNjZmU2dnpST1gyY1lVekhQR0VNc3JYeXYzWEJhRk5aSVpiQ2pNL2tmYlJs?=
 =?utf-8?B?Um5rUzJNd3llY0FmazdETTlIeTNGREpQY2JkTFQrckhuTUM5R2cwdjdxMVZm?=
 =?utf-8?B?Uy9VcnR4Q3JtUG11WTNjRk9UTHlFdTBIUXUrWnJCSUdzUnhpREduQVV3SjBu?=
 =?utf-8?B?clJOL0gzRFNGR0ZIMnQrdlRlZFZPTzFLMkVLbENQRlJ3eDdTV0NuNWRQN1Z4?=
 =?utf-8?B?cWtBd2txeFN5TDF6eEV3cUEzZWhvU3FXSm9oU1Y5Rjl2Mk9ia2taZVpSR1dx?=
 =?utf-8?B?SDUxNjBpVzZ3Q29hd2lJaGJXQ1ZJQzFLMzFMVEcyR2d5ckYyQk9nb0JneXBK?=
 =?utf-8?B?VTdRdytNOU9uVE0vZ3ltRk1YVTAvb0JnSlYwaVZFenJrbGNEb001bEpnclVx?=
 =?utf-8?Q?3B6czB957TpBdOfhUdPwbCf5u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5402a277-d620-4b98-a0a5-08dc012d66de
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 07:29:29.1698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dNtxP3CSeFvbO15dFbJ+a7DvzFHtWArIvn6oyCozxaJj/vfZpKnJ5cfjPEE0jiNgloNJgpamNnepNRpvtkiCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5272
X-OriginatorOrg: intel.com

On Tue, Dec 19, 2023 at 02:04:54PM -0700, Nathan Chancellor wrote:
> On Tue, Dec 19, 2023 at 12:58:28PM -0800, Nick Desaulniers wrote:
> > On Tue, Dec 19, 2023 at 12:54 PM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Tue, Dec 19, 2023 at 09:40:09PM +0800, kernel test robot wrote:
> > > > tree:   https://evilpiepirate.org/git/bcachefs.git header_cleanup
> > > > head:   89188fceb7a49e3c4b0578d86f6f6e647f202821
> > > > commit: 1db61740aeb7d6b1c7bfb2a98708a65a6679d068 [21/51] locking/seqlock: Split out seqlock_types.h
> > > > config: hexagon-randconfig-r005-20220913 (https://download.01.org/0day-ci/archive/20231219/202312192107.wMIKiZWw-lkp@intel.com/config)
> > > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312192107.wMIKiZWw-lkp@intel.com/reproduce)
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202312192107.wMIKiZWw-lkp@intel.com/
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    die__process_unit: DW_TAG_member (0xd) @ <0xc689> not handled!
> > > >    die__process_unit: tag not supported 0xd (member)!
> > > >    die__process_function: DW_TAG_compile_unit (0x11) @ <0xc697> not handled!
> > > >    die__process_function: tag not supported 0x11 (compile_unit)!
> > > >    die__process_function: DW_TAG_member (0xd) @ <0xc6db> not handled!
> > > >    die__process_function: DW_TAG_compile_unit (0x11) @ <0xc6e5> not handled!
> > > >    die__process_class: DW_TAG_compile_unit (0x11) @ <0xc778> not handled!
> > > >    namespace__recode_dwarf_types: couldn't find 0xc689 type for 0xc66b (member)!
> > > >    namespace__recode_dwarf_types: couldn't find 0xc638 type for 0xc674 (member)!
> > > >    namespace__recode_dwarf_types: couldn't find 0xc638 type for 0xc67e (member)!
> > > > >> /bin/bash: line 1: 19420 Segmentation fault      LLVM_OBJCOPY="llvm-objcopy" pahole -J --btf_gen_floats -j --lang_exclude=rust --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base vmlinux drivers/misc/eeprom/at24.ko
> > >
> > > Not sure how likely a header cleanup is to cause a segfault in
> > > llvm-objcopy and I don't have the toolchain to repro this - could
> > > hexagon people take a look?
> 
> For what it's worth in case you were not aware, I provide copies of LLVM
> on kernel.org that can be installed in some prefix and invoked with
> LLVM=<prefix>/bin/, which can make reproducing reports such as these
> relatively easy.
> 
> https://mirrors.edge.kernel.org/pub/tools/llvm/
> 
> > Is it a segfault in llvm-objcopy, or pahole?
> 
> Should be pahole. I have not been able to reproduce these crashes in
> pahole v1.25 in the past when they come up every so often. 0day folks,
> what version of pahole are you testing with?

We clone pahole source code from [1] and build it on the master branch.
The current head is commit c129fa757948 which is newer than v1.25.

c129fa757948 ("pahole: Add --btf_features_strict to reject unknown BTF features")

[1] https://git.kernel.org/pub/scm/devel/pahole/pahole.git

Thanks,
Yujie
