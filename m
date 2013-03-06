From: cotulla@ya.ru
Subject: Re: [Q] Guest mode in HVM
Date: Thu, 07 Mar 2013 03:27:28 +0400
Message-ID: <312941362612448@web11f.yandex.ru>
References: <48b776bf823f2b3c978065ccc6bce7b0.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1362612448; bh=MSVpXd03RgImQKWtgzliODw+4i8PaqfNJrvayIQGsNM=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=CbU/lrQRxH38qfL67Hy5+TcCsD3gK+BGzW5WklFG6I9xQ4qNCfGWpYzzvXfl2KGqy
	 kRUzl0FV1Rqrov80p99BQbbFcDco9VdOyeDSt4rnuq0WQEIxMIa4tRFCs92i0eKhPl
	 KwnM2Z6TqmkUmz5rz0C/Bg/iHj9DHBIxtk9T4SMM=
In-Reply-To: <48b776bf823f2b3c978065ccc6bce7b0.squirrel@www.codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: linux-hexagon@vger.kernel.org

Hello,


> =9ARight, the supervisor isn't subject to RWX bits, but it is still s=
ubject
> =9Ato ASIDs. =9AI think there was some other nuance to the fault hand=
ling, but
> =9Athat was the gist of it.
That's sadly :(

>
> =9AThis brings us to hypervisors which we've sort of skirted in other=
 emails.
> =9A=9AThere will be changes in the Hexagon architecture from one vers=
ion to
> =9Aanother, some of which will affect the guest operation and compati=
bility.
> =9ALong term, "we" would like to have Linux just deal with the hyperv=
isor
> =9Ainterface.
>
> =9AOf course, that isn't useful to anybody without the actual hypervi=
sor. =9AWe
> =9Arecognize this and are working hard to try to release some version=
 of a
> =9Afunctioning hypervisor for the community to continue tinkering wit=
h. =9A
Will it be releases as binary or as source code?

> If =9Awe get that out, perhaps that will be more preferable for you t=
o work
> =9Aon...
Well, we already [i]somehow[/i] almost got full working ;-)
But can be useful for another hobby developers.


> =9AThat said, I think it's great that you all are motivated enough to=
 go for
> =9Aa bare metal port in the first place (and it looks like you've mad=
e great
> =9Aprogress). =9AI see no reason to reject bare metal patches, but we=
 would
> =9Aneed to keep things clean with ifdefs/config switches...
>
Yes, we got busybox to run rather good as well. Most tests are passed.
Under "we" I mean me and Jonpry. I am working with QDSP6v2 (QSD8250B) a=
nd he is working with QDSP6v3 (APQ8060).

Another question which I want to know - QDSP6 has PIPT cache or VIPT?


Best regards,
-Cotulla
