From: cotulla@yandex.ru
Subject: [Q] Guest mode in HVM
Date: Tue, 05 Mar 2013 21:45:11 +0400
Message-ID: <139411362505511@web21e.yandex.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1362505511; bh=yTZ7DYZvlXzqzWpNRzFZ7AKilIR6eCt8ZgOwt3x2MOE=;
	h=From:To:Subject:Date;
	b=VOYin1twxHOr5DUamuIKk6d9tLTErX1i1kz/bKavI0wJG/50APLVpAZbjVKt1JOss
	 h3ZH17RgSM0X1nBmwmJbBRPP0zBGoZhpIpIppna77MfmO/BMq27AhGPtJYVsMk+C8R
	 bog+VCtYg1+0h3jzS03VQnXJO8UYT6hdQbfXQ0+8=
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-hexagon@vger.kernel.org

Hello,


I have a question:
Did I understand right that "HVM Guest mode" is actually native hexagon user mode?
And native hexagon super mode is only used inside HVM during trap1 and exception handlers?


We continued to develop our native hexagon Linux port.
Progress is good so far, we are able to run busybox from intird, but it doesn't work stable with forks

After debugging we found root case of that.

At the current moment we realize that one thing in kernel is totally wrong, out of our concept:
It's not possible to specify access mode for user/super mode in TLB.
Access mode works only for user mode, while super mode ignores it.
That a really bad thing, Linux needs that kind of feature to run.
For example during write access to usermode memory from kernel to be able to clone RW page after fork() call. fork() sets it as RO and waits page fault to make a clone of it.

Now we are redesigning it to run linux kernel also in hexagon user mode and use hexagon super mode only for small operations which are accessed by trap1calls. Actually it's simular to HVM now, thought we are not following HVM strict.

We are going to emulate separate memory access attributes (RWX) for linux kernel and linux user modes by using two different ASIDs for user and kernel mode per hw thread.  


-Cotulla
