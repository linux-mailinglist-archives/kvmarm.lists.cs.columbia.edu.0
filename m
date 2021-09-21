Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0F0412A26
	for <lists+kvmarm@lfdr.de>; Tue, 21 Sep 2021 03:01:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id BDFD84079A;
	Mon, 20 Sep 2021 21:01:42 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.91
X-Spam-Level: 
X-Spam-Status: No, score=0.91 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_ADSP_CUSTOM_MED=0.001, DKIM_SIGNED=0.1,
	DNS_FROM_AHBL_RHSBL=2.699, RCVD_IN_DNSWL_NONE=-0.0001,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@google.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iu7Vu1luhz3G; Mon, 20 Sep 2021 21:01:41 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id B68394B0F2;
	Mon, 20 Sep 2021 21:01:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id 5653C4A4C0
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 21:01:39 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pUvFrDLw3z8z for <kvmarm@lists.cs.columbia.edu>;
 Mon, 20 Sep 2021 21:01:38 -0400 (EDT)
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com
 [209.85.219.74])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id 79A234A3BF
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 21:01:38 -0400 (EDT)
Received: by mail-qv1-f74.google.com with SMTP id
 d2-20020a0caa02000000b003784ba308f1so204753119qvb.9
 for <kvmarm@lists.cs.columbia.edu>; Mon, 20 Sep 2021 18:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=PESbKZ13iPjl74hV0V0Oma6w2P6tLvn6iQL7mqbwGgo=;
 b=ppmJDLMbBlM4yiFlfHYiHNu77wvNXXA5sAEzTiwCbSu7h70G6OjhKF2mjh7FFO64Dq
 mi/BbW0+YbeqFEz87n2vqvzvrplY76fKT4uwCsAlhywV3hvoAJ/pxkM09kbB72YYNAbQ
 LaFiePNwjkwukIs52aik3fTBq2pZaR4bVRx6FpWsM/XuLeVz1+umhLvvcoo93cB9I+Cz
 PGPoF2Lf8eyERDt6eMuXk81Tfae2XfL7oQUY6eeugG7Ye+GCZRe/lRb1GD0M4Nr7N8tJ
 6i4ErXIQdOXEzvwvJtl7l5OxjvuFpswh2FxB18zrh0B9Tk4FzxAGLy7m1yMlGk+RGE9u
 ryYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=PESbKZ13iPjl74hV0V0Oma6w2P6tLvn6iQL7mqbwGgo=;
 b=4zZNy1Ga5tMgWEimmB72SdlSplbzovu5c5JTEmLZAm1V0YrdRs6crYlQQCDvlVvRWa
 wq5XI88bIh4G8057JzoLPrLSdvJlk5S9otgO25KUlUBIQ1QmnbqKrhSL2u2ynK0opycN
 HoVF/z0znf+af2Sg0+0rR4lycWxgAyXQBZdqhBrPnyyky3CB50zMOq+oIyXsjKu4A+Xp
 9Kk8GHiVMwVTPG9vYBi5ROnxmPsfNqYsFNmv9sKkIpUGxD3Ws9HPHR3shfxxJiuxQ2X8
 0Oumi0CEW5PUPx+XzIsfKjfesXHDvzOhVEXwPTUAa5+P18jTVw5Vs3XkcyUtxR0+TGa1
 jHuA==
X-Gm-Message-State: AOAM530RNx7GfCltz71x1hi6IwB6VcWco5Jqmh585l4ibzMatKLxUnmi
 zXLAX5G3Zw/1+ZMPAUvtHDvQxUrQ6hg=
X-Google-Smtp-Source: ABdhPJxxD5Psn8NbnOGzgjmoMwHo/NRrqGL/Hz5g2R/wXaxij8FsuN33N5paHz3bIg3BU/k6S4n92x/nUM4=
X-Received: from oupton.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:404])
 (user=oupton job=sendgmr) by 2002:a05:6214:122e:: with SMTP id
 p14mr28597769qvv.37.1632186098021; Mon, 20 Sep 2021 18:01:38 -0700 (PDT)
Date: Tue, 21 Sep 2021 01:01:19 +0000
In-Reply-To: <20210921010120.1256762-1-oupton@google.com>
Message-Id: <20210921010120.1256762-2-oupton@google.com>
Mime-Version: 1.0
References: <20210921010120.1256762-1-oupton@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 1/2] selftests: KVM: Fix compiler warning in demand_paging_test
From: Oliver Upton <oupton@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Cc: Marc Zyngier <maz@kernel.org>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>
X-BeenThere: kvmarm@lists.cs.columbia.edu
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Where KVM/ARM decisions are made <kvmarm.lists.cs.columbia.edu>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu

Building demand_paging_test.c with clang throws the following warning:

>> demand_paging_test.c:182:7: error: logical not is only applied to the left hand side of this bitwise operator [-Werror,-Wlogical-not-parentheses]
                  if (!pollfd[0].revents & POLLIN)

Silence the warning by placing the bitwise operation within parentheses.

Signed-off-by: Oliver Upton <oupton@google.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index e79c1b64977f..10edae425ab3 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -179,7 +179,7 @@ static void *uffd_handler_thread_fn(void *arg)
 			return NULL;
 		}
 
-		if (!pollfd[0].revents & POLLIN)
+		if (!(pollfd[0].revents & POLLIN))
 			continue;
 
 		r = read(uffd, &msg, sizeof(msg));
-- 
2.33.0.464.g1972c5931b-goog

_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
