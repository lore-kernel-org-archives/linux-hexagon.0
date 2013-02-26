From: cotulla@yandex.ua
Subject: Re: [DISCUSSION] Hexagon code inside kernel
Date: Tue, 26 Feb 2013 23:32:40 +0400
Message-ID: <195171361907160@web18e.yandex.ru>
References: <1163031361018389@web26d.yandex.ru>
	<1361593470.29465.17@driftwood> <1982671361708622@web15h.yandex.ru> <1361861719.15497.0@driftwood>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1361907160; bh=yDQBBzrrSakdx7C48o+rHJYhDnRi1GNeW0o0cSnnvsM=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=bBiK0GgtNAhO6gHYB/1mZPGBQ7Zlysy3HoCaplvFgwxAy2z8XNlH+AtIShYBQCtOe
	 x41UtCMevOQDjw/FADiV1E2YJrzfxbZg7X9wyXdG0VKVom5hB5gsKdT1iNIUZjEx53
	 jllvu6KmxPlEY40XnLbIOi0hGWx3NL+pCt3uxDjs=
In-Reply-To: <1361861719.15497.0@driftwood>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org


> =9AI think I've missed chunks of this conversation: what are you boot=
ing
> =9Ait on?
>
> =9A(Wondering if I can get a test environment together. I haven't had=
 one
> =9Asince I left qualcomm in 2010.)
>

Actually at the current time two persons are did some work in that proj=
ect:
0)Cotulla (me) - HTC HD2 (HTC LEO) QSD8250B QDSP6v2
Image load done by custom MAGLDR bootloader.

1)jonpry - HP TouchPad (APQ8060) QDSP6v3
Image load done from kernel via PIL AFAIK.
He also tried it on APQ8064 with QDSP6v4 but no luck with loading unsig=
ned LPASS images.


Current kernel code located here in GIT:
We took clear tree Linux 3.7.6 at the start and started to work with it=
=2E
https://github.com/detule/linux-hexagon


I am trying to bring up USB garget driver now.
Already found that arm/mach-msm is also nosense. In common it's bad, ug=
ly code for something mythic.=20
I was trying to use a built in chipidea driver, but it looks extremely =
overloaded and doesn't really fits for LEO hardware.=20
I think I will try to port old msm7k_udc.c driver from 2.6.35. It's muc=
h more simple.


Also I found that adding "volatile" to variable declaration puts all ac=
cesses to it as not grouped into packets.
So it can be easy workaround for uncached memory access problem, instea=
d of replacing everything to ioread32 and iowrite32.


-Cotulla
