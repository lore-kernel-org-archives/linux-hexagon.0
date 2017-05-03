From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] hexagon: Use raw_copy_to_user
Date: Tue,  2 May 2017 20:52:48 -0700
Message-ID: <1493783568-9887-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-hexagon-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TI5P2ZzkvZtNIPUnS0phXqjqPWwHdi+rYKlGznOJWQ8=; b=nK3zaxrhXYqFRHku6FAC065DLp
        PnS6YEqcT2AXjH9vhfm9z8i35swnybUhAvyMAsE1GsX/W3sEc1iaJq575cAqIc5sKS1mh57ANGX3J
        aq2FYhX8fZD5CMDwpWfFAobZHZoIh46EMt4v8AV6NuRML1BSrrH1Vy5q4A1WQp6Wd2SjToLswnC4H
        YUELkgxBk7foy4ZtAcknGAw6/U5SZzV9uk8ugUAvdXccJxXcx4tJktXse/MYCpvVzSAxdeyUBilGB
        l7hbK+FLJyqVWHxNoYsWMUOndRtKI27lcsM+lIzj51GjvL8TRcEwfH6VBOvEcFoJVI49vJZq1A8Pk
        u2OkYF 
Sender: linux-hexagon-owner@vger.kernel.org
List-ID: <linux-hexagon.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>

Commit ac4691fac8ad ("hexagon: switch to RAW_COPY_USER") replaced
__copy_to_user_hexagon() with raw_copy_to_user(), but did not catch
all callers, resulting in the following build error.

arch/hexagon/mm/uaccess.c: In function '__clear_user_hexagon':
arch/hexagon/mm/uaccess.c:40:3: error:
	implicit declaration of function '__copy_to_user_hexagon'

Fixes: ac4691fac8ad ("hexagon: switch to RAW_COPY_USER")
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/hexagon/mm/uaccess.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/hexagon/mm/uaccess.c b/arch/hexagon/mm/uaccess.c
index ec90afdb3ad0..c599eb126c9e 100644
--- a/arch/hexagon/mm/uaccess.c
+++ b/arch/hexagon/mm/uaccess.c
@@ -37,15 +37,14 @@ __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count)
 	long uncleared;
 
 	while (count > PAGE_SIZE) {
-		uncleared = __copy_to_user_hexagon(dest, &empty_zero_page,
-						PAGE_SIZE);
+		uncleared = raw_copy_to_user(dest, &empty_zero_page, PAGE_SIZE);
 		if (uncleared)
 			return count - (PAGE_SIZE - uncleared);
 		count -= PAGE_SIZE;
 		dest += PAGE_SIZE;
 	}
 	if (count)
-		count = __copy_to_user_hexagon(dest, &empty_zero_page, count);
+		count = raw_copy_to_user(dest, &empty_zero_page, count);
 
 	return count;
 }
-- 
2.7.4
