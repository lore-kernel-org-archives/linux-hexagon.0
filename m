From: cotulla@yandex.ru
Subject: [DISCUSSION] Hexagon code inside kernel
Date: Fri, 15 Feb 2013 18:28:14 +0400
Message-ID: <1093431360938494@web22d.yandex.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1360938494; bh=7JbHv4fxhYSw6ubLIqGgoCdPCQOC5qPNN5g0gDaCgG0=;
	h=From:To:Subject:Date;
	b=dnpwpSVMm1th8cAUWLJPAayXMx4NukCD0Q6rr6cH80qmaZ1BUKQ0v4zrE4dTpPoGM
	 kp743MHcu2iyKQ85JMqAC+9qf0toN2uGul79DaDHvS61NHVK+ska0UMaRR7xM8VUrM
	 2qLlOma9A4oAG/LNnn78+OWEGEaiNdTSl98zfexY=
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-hexagon@vger.kernel.org

Hello,


Some time ago (I think inside 3.4) Hexagon architecture support was added into Linux kernel.
Hexagon (another name is QDSP6) is a special DSP processor which was developed by Qualcomm Inc.
Qualcomm provided a set of patches to include Hexagon support inside Linux kernel.
QDSP6 is used inside a lot of different SoC (QDS8650B, MSM8960, APQ8064, etc) which are very common inside modern smartphones.  


However after deep looking inside those patches I found that this code is only supposed to be run on top of some mythic "Hexagon Virtual Machine".
"Hexagon Virtual Machine" is not available for free download in source code or either in binary form.
I guess it's only available for Qualcomm customers by signing NDA.
This prevents actually to run own home builded kernels on real QDSP6.

Personally I am a homebrew hobby developer, who like to experiment with different intersting stuffs inside modern smartphones.
And I want to have ability to be able build and run Linux kernel on Hexagon processor.
I think including of such code inside official open source kernel is nosense - Qualcomm wants to use open source community for own interests and doesn't provide anything back by hidding actual hardware interfaces inside non-available free Virtual Machine. 

So I am curious why it's included to the offiicial mainline kernel tree? 
And how kernel developers are going to support and test that architecture without actual running hardware?

Can this be threaded as GPL violation?
This kernel code is using "trap1" instruction which actually switches execution to exception handler located inside VM.


Best regards,
-Cotulla
