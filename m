Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7B189BAC;
	Mon, 30 Sep 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711456; cv=none; b=H8OLYM8Yt9jtfHnAMHFdiR+/2zxlQnHgCriSgJCF14ir3kma8ll/ndV1KJ9Apm1x3RQVewESoWLPyI4PSFIfZvWV/nmsAPcrpWQi8GBc2+d6uRGXqalckgJZBg0VL4zjZIxxS0woMSzWDx7to3mrDZC0+zEljyPEUr4mSMY5hqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711456; c=relaxed/simple;
	bh=38/1vLRS7rCKVRWaB84+o3nuFBsPMC371LzQmWzOxSg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJWo3Jk4CucqPyjCyJCChZcVw2RyiCoPTNkIgcWaS9GE4WmlCMboJOoPsAxm0v23HQyzvE5S89OJQ+TJMeTadyhos9QtSOgbCenKCIpjOhJiGwx66wPPiMBk0DGPB50BE3twW5XnL0n9rnJTJgWhmErUERZBOtVqgsY42F1fGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C/1rtQ3H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C/1rtQ3H"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UEu6m3003494;
	Mon, 30 Sep 2024 15:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	LXQ8PrKWtR6B/UWG6A7R2z1jwOQF+2mpJDAe/vDg6aA=; b=C/1rtQ3HkTkZjQUb
	XBt/TJEAUbCJyBvyjGp+gnSjgHREKoMFOZysXPt6Xu5nbLaB+JUWJiVOA8hEDtdz
	jT5Udli5BnIlHiBGS8b3KqRCW8vYZIWuA4hPk9FcmwARSgIUTr0lCB/cvl2iT9xF
	poKvo1EkmV1KVAUO32ZFSUdAPQ82/BEUwB5IjdxF52lMmE7BOZG5ntYfnIMlMaHu
	y3IZhjihYTnNJOaYE1OckCVvEnnsJbcH96rbmzjijxqzn4c7SicyyAz6fVRHfFK8
	bDpXvc+jWTZvjQ7YhTMCBFptwrwBTuvmR3NOmCP8oLEk6+uIrlbyNOzgroDgTc4N
	WXxqAg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwtsfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 15:50:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UEdpvb017905;
	Mon, 30 Sep 2024 15:50:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mqc3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 15:50:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UFokqb47907322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 15:50:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F94E58053;
	Mon, 30 Sep 2024 15:50:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57AB85805F;
	Mon, 30 Sep 2024 15:50:45 +0000 (GMT)
Received: from [9.179.7.149] (unknown [9.179.7.149])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 15:50:45 +0000 (GMT)
Message-ID: <6c8daef875f9981c59fc5ce9c81eb8c3c2618b5c.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
 HAS_IOPORT support
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Brian Cain <bcain@quicinc.com>
Cc: "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Arnd
 Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 30 Sep 2024 17:50:44 +0200
In-Reply-To: <CH3PR02MB10247A45A17F7D8104D1922A8B83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
References: <20240403132447.719833-1-schnelle@linux.ibm.com>
	 <20240403132447.719833-2-schnelle@linux.ibm.com>
	 <CH3PR02MB10247296630FC062F4E3DE2FDB83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
	 <c04ed601dbd0a8053e034fef1c05ce2ca6e95392.camel@linux.ibm.com>
	 <CH3PR02MB10247A45A17F7D8104D1922A8B83D2@CH3PR02MB10247.namprd02.prod.outlook.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-hexagon@vger.kernel.org
List-Id: <linux-hexagon.vger.kernel.org>
List-Subscribe: <mailto:linux-hexagon+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hexagon+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lrXFTQXdstessQdWIf6ryTeVl5zMskgb
X-Proofpoint-GUID: lrXFTQXdstessQdWIf6ryTeVl5zMskgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=451 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300113

On Wed, 2024-04-03 at 15:37 +0000, Brian Cain wrote:
>=20
> > -----Original Message-----
> > From: Niklas Schnelle <schnelle@linux.ibm.com>
> > Sent: Wednesday, April 3, 2024 10:22 AM
> > To: Brian Cain <bcain@quicinc.com>
> > Cc: linux-hexagon@vger.kernel.org; Arnd Bergmann <arnd@kernel.org>;
> > Heiko Carstens <hca@linux.ibm.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
> > HAS_IOPORT support
> >=20
> > WARNING: This email originated from outside of Qualcomm. Please be wary
> > of any links or attachments, and do not enable macros.
> >=20
> > On Wed, 2024-04-03 at 14:51 +0000, Brian Cain wrote:
> > >=20
> > > > -----Original Message-----
> > > > From: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > Sent: Wednesday, April 3, 2024 8:25 AM
> > > > To: Brian Cain <bcain@quicinc.com>
> > > > Cc: linux-hexagon@vger.kernel.org; Arnd Bergmann <arnd@kernel.org>;
> > > > Heiko Carstens <hca@linux.ibm.com>; linux-kernel@vger.kernel.org;
> > Niklas
> > > > Schnelle <schnelle@linux.ibm.com>
> > > > Subject: [PATCH 1/1] hexagon: Don't select GENERIC_IOMAP without
> > > > HAS_IOPORT support
> > > >=20
> > > > WARNING: This email originated from outside of Qualcomm. Please be
> > wary
> > > > of any links or attachments, and do not enable macros.
> > > >=20
> > > > In a future patch HAS_IOPORT=3Dn will disable inb()/outb() and frie=
nds at
> > > > compile time. As hexagon does not support I/O port access it also
> > > > the GENERIC_IOMAP mechanism of dynamically choosing between I/O
> > port
> > > > and
> > > > MMIO access doesn't work so don't select it.
> > > >=20
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > >  arch/hexagon/Kconfig | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> > > > index e233b5efa276..5ea1bf4b7d4f 100644
> > > > --- a/arch/hexagon/Kconfig
> > > > +++ b/arch/hexagon/Kconfig
> > > > @@ -31,7 +31,6 @@ config HEXAGON
> > > >         select HAVE_ARCH_TRACEHOOK
> > > >         select NEED_SG_DMA_LENGTH
> > > >         select NO_IOPORT_MAP
> > > > -       select GENERIC_IOMAP
> > > >         select GENERIC_IOREMAP
> > > >         select GENERIC_SMP_IDLE_THREAD
> > > >         select STACKTRACE_SUPPORT
> > >=20
> > > Reviewed-by: Brian Cain <bcain@quicinc.com>
> > >=20
> >=20
> > Thanks for the R-b, which tree should take this? If you have other
> > hexagon changes for v6.10 I think it would be easiest to take this
> > together with those. As mentioned in the cover letter the per-subsystem
>=20
> I don't have other changes planned for v6.10 but I'm happy to take the ch=
ange in my tree.
>=20
> > changes are all independent until HAS_IOPORT=3Dn actually disables
> > inb()/outb() which Arnd will take once all the subsystems are covered.
> >=20
> > Thanks,
> > Niklas

Hi Brian,

With 2 more of my HAS_IOPORT patches having gone into v6.12-rc1 I just
noticed that this one seems to have fallen into the cracks. This is
probably my fault for not properly confirming that I'd be happy for you
to take it. Do you want me to resend a new version rebased on v6.12-
rc1?

Thanks,
Niklas
