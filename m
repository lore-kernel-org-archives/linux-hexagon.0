Return-Path: <linux-hexagon-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E217C0018A
	for <linux-hexagon@archiver.kernel.org>; Mon,  6 Nov 2023 13:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjKFNVW (ORCPT
        <rfc822;linux-hexagon@archiver.kernel.org>);
        Mon, 6 Nov 2023 08:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjKFNVT (ORCPT
        <rfc822;linux-hexagon@vger.kernel.org>);
        Mon, 6 Nov 2023 08:21:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD1DD4D
        for <linux-hexagon@vger.kernel.org>; Mon,  6 Nov 2023 05:21:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D83C433C7;
        Mon,  6 Nov 2023 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276876;
        bh=DBJnkGveK5wDhm9D6DvxoIIWAPGqXcBWviR5KkzYoSY=;
        h=Date:From:To:Subject:From;
        b=YdBMb+E7Q7ARyzJkVrZa8GJh1kI+00w51jaYstD6Re9yZGXk5hm47EnEc8YhzUktM
         cOfMI1/OuiVJQArK4wQXQ/wVN57UlbJq6rU0eZsnFFaA+SoUy7neDZIbbzCjkgzp5g
         kUF+PS0IOmmFNP9l8iiYN6v2lwFexGw11xNc2d9s=
Date:   Mon, 6 Nov 2023 08:21:15 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     linux-hexagon@vger.kernel.org
Subject: PSA: migrating linux-hexagon to new vger infrastructure
Message-ID: <20231106-uncovered-boar-of-support-3aba0d@nitro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hexagon.vger.kernel.org>
X-Mailing-List: linux-hexagon@vger.kernel.org

Good day!

I plan to migrate the linux-hexagon@vger.kernel.org list to the new
infrastructure this week. We're still doing it list-by-list to make sure that
we don't run into scaling issues with the new infra.

The migration will be performed live and should not require any downtime.
There will be no changes to how anyone interacts with the list after
migration is completed, so no action is required on anyone's part.

Please let me know if you have any concerns.

Best wishes,
-K
