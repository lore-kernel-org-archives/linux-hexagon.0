From: Richard Kuo <rkuo@codeaurora.org>
Subject: Hexagon MiniVM
Date: Wed, 24 Apr 2013 19:48:20 -0500
Message-ID: <51787D54.2070404@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-hexagon@vger.kernel.org

Hello everyone,

We have released a version Hexagon MiniVM on Code Aurora Forum which can 
be found here:

https://www.codeaurora.org/projects/all-active-projects/hexagon-minivm

This is a reference implementation for the hypervisor layer that 
provides the Hexagon Virtual Machine which our kernel port is 
paravirtualized for.

Please note that this is a really simplistic version that doesn't have 
any advanced features -- it's really meant to allow a single guest to 
actually run.  I think that some of you might have already 
re-implemented these features in your bare-metal work, but maybe this 
code will still be helpful.


Regards,
Richard Kuo



-- 

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
