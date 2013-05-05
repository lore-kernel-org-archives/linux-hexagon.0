From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] HEXAGON: Remove non existent reference to GENERIC_KERNEL_EXECVE & GENERIC_KERNEL_THREAD
Date: Sun,  5 May 2013 15:58:28 +0400
Message-ID: <1367755108-13169-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
	h=Message-Id:Date:Subject:Cc:To:From; bh=mH+eC6SQg8lnXG/O1JEL2DFyH6LP5ANNodK3bzYOKsE=;
	b=mJ+u2THbE8HJ95GMl/DUqtow2gNnjYEuofTk/D+ntP51WALreQzS4APhvNNAFKiE4UfjJ1wg6XjNVDTeRwxs5gqwfysVqEQu0PX5QjG/tK5yh5rmm1WNLForZzkEX0YVETpkLX5BtDyV9rQLzYdEWhIMqILV9/F/tGWAsaCJNCw=;
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-hexagon@vger.kernel.org
Cc: Richard Kuo <rkuo@codeaurora.org>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/hexagon/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index b418471..33a9792 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -30,8 +30,6 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
-	select GENERIC_KERNEL_THREAD
-	select GENERIC_KERNEL_EXECVE
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
-- 
1.8.1.5
