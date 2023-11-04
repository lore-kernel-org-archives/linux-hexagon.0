Return-Path: <linux-hexagon-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC5DC4167D
	for <linux-hexagon@archiver.kernel.org>; Sat,  4 Nov 2023 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjKDJQ4 (ORCPT
        <rfc822;linux-hexagon@archiver.kernel.org>);
        Sat, 4 Nov 2023 05:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjKDJQw (ORCPT
        <rfc822;linux-hexagon@vger.kernel.org>);
        Sat, 4 Nov 2023 05:16:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A92194
        for <linux-hexagon@vger.kernel.org>; Sat,  4 Nov 2023 02:16:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc1e1e74beso25464755ad.1
        for <linux-hexagon@vger.kernel.org>; Sat, 04 Nov 2023 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699089387; x=1699694187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SLNQXwvsmuV3fVIiwVg4eaHyhonWOyCC10q8MYVA8E8=;
        b=MtMgam8o+3y23wLubmu2Met3dmmSp5k1T27AY9yRvH6jq1d3c8n4pwEixLB5n8dvUb
         8RIvBiEopV8pdyatqcjHSDOzDEY4LleRDBBs3j4aG3rz3/PJNlIJ3QX9twdwSEs6tjpL
         9JAC7UeVje7kw+KwhWC+E0aeg+I+uLajEH3XZgvOHRJMZVQm69oUdDkuxj07qNRDgcdU
         Gda7zCT9dbtxOQNj5suysj4Cr6n17vAY3uR7SpFTotFjFgLWD9UEM+aWIwm7wP94M/0j
         tRhbVQw7bmzy1GtL76RMW8tcAFvMJ9InMVbRX9C7TgF+TIqPjM2HNRx1m0yzo9h+3yET
         JUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699089387; x=1699694187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLNQXwvsmuV3fVIiwVg4eaHyhonWOyCC10q8MYVA8E8=;
        b=uua6mJa4cxwqOZZ5AnXEgOMm2Zq3DNjEj8OJmPDyJilLrokqg+3FUXCYsYSIM2ocgq
         wGd3ieVgzE+Jm1P4/JA0jxcFA+TB/Oc33nB+Aw2k3Pezym0T+wozO+pst1TLbJ1q31y7
         bzjZKGfIv3JNwPE6YoW37NJVHD3/HfcOG71ddj/WqYsuRltonTkfvD96av4bPIcOA6p7
         I51qxgEIqZ4EUiQiSfE+3pshMHPY7rmqp/pImMMkratCY2O/HHS+skd3JGnbGNj6FVRt
         jXqKy0cv2W9Q0/vxfS0h6UEhDbWp6/64ar8+6qL5NQHyTDct+UwLBHPXbsJElkISZ2VK
         R3Xw==
X-Gm-Message-State: AOJu0YzC6TU04PFre+Vu0SvPLd8B833KWcfTA1UqjlrBReaEGspFSS9X
        De1f9BW3VwWcyLCpp4wIYR2E5Q==
X-Google-Smtp-Source: AGHT+IHbBh3J3IRfyxckxOWlsKX9sadU7+kPzJ+J9v34NvpVCI+Bhzyj9lMKHXCD1k0j5ZNgkIMKOQ==
X-Received: by 2002:a17:902:f213:b0:1bc:6c8:cded with SMTP id m19-20020a170902f21300b001bc06c8cdedmr22211228plc.67.1699089387534;
        Sat, 04 Nov 2023 02:16:27 -0700 (PDT)
Received: from devz1.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b001cc54202429sm2585127plh.288.2023.11.04.02.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:16:27 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     vgupta@kernel.org, bcain@quicinc.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        geert@linux-m68k.org, andi.shyti@linux.intel.com, mingo@kernel.org,
        palmer@rivosinc.com, andrzej.hajda@intel.com, arnd@arndb.de,
        peterz@infradead.orgm, mhiramat@kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mattwu@163.com,
        linux@roeck-us.ne, "wuqiang.matt" <wuqiang.matt@bytedance.com>
Subject: [PATCH v2 0/4] locking/atomic: arch_cmpxchg[64]_local undefined
Date:   Sat,  4 Nov 2023 17:16:11 +0800
Message-Id: <20231104091615.4884-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hexagon.vger.kernel.org>
X-Mailing-List: linux-hexagon@vger.kernel.org

This patch series implement arch_cmpxchg[64]_local for arc,
openrisc and hexagon.

For architectures that support native cmpxchg, we'd like to
implement arch_cmpxchg[64]_local with the native variants of
supported data size. If not, the generci_cmpxchg[64]_local
will be used.

wuqiang.matt (4):
  locking/atomic: arc: data size checking in arch_cmpxchg
  locking/atomic: arc: arch_cmpxchg[64]_local undefined
  locking/atomic: openrisc: arch_cmpxchg[64]_local undefined
  locking/atomic: hexagon: arch_cmpxchg[64]_local undefined

 arch/arc/include/asm/cmpxchg.h      | 40 ++++++++++++++++++----
 arch/hexagon/include/asm/cmpxchg.h  | 51 ++++++++++++++++++++++++++++-
 arch/openrisc/include/asm/cmpxchg.h |  6 ++++
 3 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.40.1

