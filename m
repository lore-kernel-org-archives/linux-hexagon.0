From: cotulla@yandex.ru
Subject: Serious error in the code
Date: Sat, 02 Mar 2013 17:59:40 +0400
Message-ID: <1481681362232780@web23d.yandex.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1362232780; bh=iAHg58LVgmgAoaDkRdgZKPsV+B3ozIVz94TC9bskTwU=;
	h=From:To:Subject:Date;
	b=q6aewxBQO1twTOGNzXXMJrKivNVETmdjq7GGkqEXNqjli/O2FLyZ+heYRCu2V1A0c
	 sk5mVEYja3kSmnDqD1CvLrhqk3y44B5T0RaS0gIyki501vNlPWalhuoBtDPPJuts0q
	 41iBkvSA3jb8D22ggsrcM38DW9MYHRmWfWsOhKwo=
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-hexagon@vger.kernel.org

Hello,


During porting we found a serious error:

Function 
static inline int __atomic_add_unless(atomic_t *v, int a, int u)
is implemented wrong.
Hexagon implementation returns 0 or 1, while it _must_ return old value.

linux/atomic.h defines it as:

static inline int atomic_add_unless(atomic_t *v, int a, int u)
{
         return __atomic_add_unless(v, a, u) != u;
}
So it's really supposed for __atomic_add_unless return old value, not 0/1 flag.
And finally atomic_add_unless returns 0/1 flag by comparing values.

I think developer was confused by atomic_add_unless() description which is different from __atomic_add_unless().

This was a very awful error. . .dunno how it worked before.

However this is not the first error in the code - for example hexagon_dma_init() is never called outside.
I am really surprised that this was ever included to mainline. Dead, not working code with a lot of errors for some abstract private HVM.


Best regards,
-Cotulla
