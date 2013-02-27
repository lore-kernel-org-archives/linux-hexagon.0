From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Wed, 27 Feb 2013 16:39:52 +0400
Message-ID: <910561361968792@web30f.yandex.ru>
References: <5251361904861@web14e.yandex.ru> (from cotulla@yandex.ua on Tue
	Feb 26 12:54:21 2013) <1361926695.18483.1@driftwood>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361968792; bh=x7psZxh4GF6H6MxW58XtCdaW3Gf8xJVgcokor7wemQY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=Xwk3mhgC1xOJduFpPEeN8CvVdM1kgzxADAHWJhsU1OUb1KSvzhFF0sHwzyiI8Wj8c
	 Xr+8ddp3PO80kSVMkViER/Xa/9nao+y4D1jf0UujUjF2rlkmMtuERl2zPfLdACaosR
	 2wQl4Xq1V7cA9JCBKmI357jrO+bbA9Id3z2eLLKE=
In-Reply-To: <1361926695.18483.1@driftwood>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org


> =9AI miss having that myself. I built Aboriginal Linux on target and =
built
> =9ALinux From Scratch and chunks of Beyond Linux From Scratch under i=
t and
> =9Athe result was a fairly decent machine. I would love to support it=
 in
> =9Amy upstream vanilla projects, but Qualcomm never gave me (or anyon=
e
> =9Aelse) the tools to do that outside of employee context.

I wanna get USB Ethernet connection, it looks suitable for remote acces=
s.
Another approach - get Android's ADB to run.

=20
> =9AThey're backwards but not forwards compatible. v2 works on v3 and =
v4,
> =9Abut v4 may not work on v2. (Most architectures work that way.)
>
Well, v3 claims to have different ABI, so ever userland files are not c=
ompatible.
I am talking about low level system definitions on source level.
v4 has changes inside them (new TLB format and etc).


-Cotulla
