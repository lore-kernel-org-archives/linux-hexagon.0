From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH 0/2] arch: hexagon: include: asm: add prefix "vm_" for all
 enum members in "hexagon_vm.h"
Date: Mon, 25 Nov 2013 10:39:01 +0800
Message-ID: <5292B845.3010404@gmail.com>
References: <528AEFB7.4060301@gmail.com> <20131125011938.GB18921@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=C3RpfDch5tC1gfMbM+GTvHcYRDZBKZFZGVzpg2byaqw=;
        b=rGFAjO6qdjWIKEL9Npm0CDZuDfPZAF5s8XLO955DKSqhZkkVxG4owcvrzNjTDKJSaA
         foAE7l3VJOpb343o3Z6Y42w8+zzxMLZU9gZ9SHOyEqmaP60y8CIY+yJLE9h6mRsdC8WI
         2RhvM6eEtx3SdxxDF3jiRLXpK2Cr39EkeKTJY/QXphYnYbF2Bi1vcZXK4+84KblfrioT
         Lwddyh+599S2zyOcs4GUpJfPwUJL4A659AeFF4BrOa8kuBhG+DVs8d/4DXxLeC4P3VYY
         0paLz8fsp+w3Jy3OfelGjrXehA6vmUS659Hk3Q4nlgbnsLCV7GCLeHCl2Gh+aCK3ZPgy
         qijQ==
In-Reply-To: <20131125011938.GB18921@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rkuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Append "vm_" to all enum members (which are too common to make conflict
with another sub-systems). The related error with allmodconfig:

    CC [M]  drivers/md/raid1.o
  drivers/md/raid1.c:1440:13: error: 'status' redeclared as different kind of symbol
  arch/hexagon/include/asm/hexagon_vm.h:76:2: note: previous definition of 'status' was here

Also fix a typo issue: use 'affinity' instead of 'locdis' for
__vmintop_affinity() in "hexagon_vm.h"


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/hexagon/include/asm/hexagon_vm.h |   72 ++++++++++++++++----------------
 1 files changed, 36 insertions(+), 36 deletions(-)
