Return-Path: <kvmarm-bounces@lists.cs.columbia.edu>
X-Original-To: lists+kvmarm@lfdr.de
Delivered-To: lists+kvmarm@lfdr.de
Received: from mm01.cs.columbia.edu (mm01.cs.columbia.edu [128.59.11.253])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFEE387FD2
	for <lists+kvmarm@lfdr.de>; Tue, 18 May 2021 20:43:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id A1CF24B557;
	Tue, 18 May 2021 14:43:20 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
X-Spam-Flag: NO
X-Spam-Score: 0.21
X-Spam-Level: 
X-Spam-Status: No, score=0.21 required=6.1 tests=[BAYES_00=-1.9,
	DKIM_SIGNED=0.1, DNS_FROM_AHBL_RHSBL=2.699,
	MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
	T_DKIM_INVALID=0.01] autolearn=no
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@oracle.com
Authentication-Results: mm01.cs.columbia.edu (amavisd-new); dkim=softfail
	(fail, message has been altered) header.i=@oracle.onmicrosoft.com
Received: from mm01.cs.columbia.edu ([127.0.0.1])
	by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bxLVAHLq00wY; Tue, 18 May 2021 14:43:19 -0400 (EDT)
Received: from mm01.cs.columbia.edu (localhost [127.0.0.1])
	by mm01.cs.columbia.edu (Postfix) with ESMTP id 51BA34B576;
	Tue, 18 May 2021 14:43:18 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mm01.cs.columbia.edu (Postfix) with ESMTP id BD86E4B361
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 May 2021 14:40:55 -0400 (EDT)
X-Virus-Scanned: at lists.cs.columbia.edu
Received: from mm01.cs.columbia.edu ([127.0.0.1])
 by localhost (mm01.cs.columbia.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VlcNMwtxH-xe for <kvmarm@lists.cs.columbia.edu>;
 Tue, 18 May 2021 14:40:54 -0400 (EDT)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by mm01.cs.columbia.edu (Postfix) with ESMTPS id A00654B34F
 for <kvmarm@lists.cs.columbia.edu>; Tue, 18 May 2021 14:40:54 -0400 (EDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14IIQ8lW002389; Tue, 18 May 2021 18:40:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ucht5mFIVx/1JCY9g/45fa/Tzad5VOzFcqOiaQAZHi8=;
 b=uDQ7O5Lg/OTgpQGai+V6GSF4IK8n0+jA+9sVkgjJIvkrlvlkG5DX9k8xR16YeIDJicCy
 aJJTiGJtfGuP3ULFoKJ1V2mNgkEK/O/2eLsjUuaVYhu5bRe0p34F96O/mW0mgrEGgCMU
 qKhBNsm9ftwc71j6/jlNOUBSb/3iQAaPMKsZhKoBQv5o7hr3H4Rxp0qphfOSSqsnXRy1
 fdsZgb9xKfZbz13cz5lDxvm8baUYHDb9ZLACUz/Kz1JWwIf8SBu44lsqUvUwd0xQvZSe
 FcAT9E/i+Pv69D9bbkCcVvlo5aUR4ysrMJDcnlib8jJSlr9OVNhEyzngME1R3phwzlRY DA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 38kfhwgt30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 May 2021 18:40:44 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
 by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14IIcHZC095322;
 Tue, 18 May 2021 18:40:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 by userp3030.oracle.com with ESMTP id 38megjqwbn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 May 2021 18:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFv1APPn8OnHmD/U7taCY00LonS+hVsm0hkEtsnaDxI7DGZObtZxzVIviiIeGSi08EIxotLpekFfMx0B2Fc6aDZFrDQr49jM9/CXGKRFA2CQjgXW/OQxiClFNzr4WI0C97BlkuSkUWL4KpR7GOk4oV6mnRpDuwp+RHv3WJhV7L9GqJpPfssjYqSf9qheSQ98Z875N6Bv/h/2jFXhYMWNb7To4fZMMB18w2JuR8YUsN7fmCxQd8xyWNFhOLZJFQ+nYIl9xXp3mjK3RvvKeHyWFtvsq7fRX/dS+ETz8d63WZk212MnN6I+ebVDPk4HkIjoaOXDTXMTvEwUsIfHw8O66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucht5mFIVx/1JCY9g/45fa/Tzad5VOzFcqOiaQAZHi8=;
 b=TBvEcVkgjQLWHKA9zroZ6GqLkV586Gu0knETUoGNrNPHZYPcEgVYcYriNB84U1wsVZDys/QjGjb7JX12ijd/MzabL5syhTsi20ArGgY16cyd18XMG/1OHbTqN42oV52v5ieWy9jCfASGV6DFvf6jvnonw6l6vUXk7gopteEFgnHfmSil3YcMwXKEBzeTWHcqvuReNqqfx62pZaqYkDR5vyKmH/zTTGkScr/LbgqrE5vlh0jsu+zt/gbmVFofw51kE4Qta95ORaANes3nV7nkISP6rb/skaGaHqubZLaC2/h9e6+RA60MQAx5i/yTDNjDWqzbMwhJZ0VlSKQSJqNDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucht5mFIVx/1JCY9g/45fa/Tzad5VOzFcqOiaQAZHi8=;
 b=jBcczwnnmNGMvuqDuPB8CG3o33zE3dgVYqeuCmk0eRrkCfbUlSCtW0DxZtOzV7pPtF1Lq+a5t/1lW8V0Jfchd3Kmz6ydrfXjZOvY1rXfp0knHdMwUnwU4nw6TIh9QroZlxfqVvNF0WK6KH3ftkjPfPmg6QUwG4VSCSnn2pn6W7E=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB3021.namprd10.prod.outlook.com (2603:10b6:805:cc::19)
 by SA2PR10MB4506.namprd10.prod.outlook.com (2603:10b6:806:111::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 18:40:41 +0000
Received: from SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::5911:9489:e05c:2d44]) by SN6PR10MB3021.namprd10.prod.outlook.com
 ([fe80::5911:9489:e05c:2d44%5]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 18:40:41 +0000
Subject: Re: [PATCH v5 1/4] KVM: stats: Separate common stats from
 architecture specific ones
To: Jing Zhang <jingzhangos@google.com>, David Matlack <dmatlack@google.com>
References: <20210517145314.157626-1-jingzhangos@google.com>
 <20210517145314.157626-2-jingzhangos@google.com>
 <CALzav=dGT7B7FWw_d5v3QaJxgfp6TZv7E4fdchG_7LKh+C17gg@mail.gmail.com>
 <CAAdAUtjyFhuh4iFJJOkkO20XXKqbcRO-S0ziFfUW1rHL-bkeZw@mail.gmail.com>
 <CALzav=dHjy8wnLckxifrjVDfVNBmqHcJgeS7PK6BnAp6UCyO5A@mail.gmail.com>
 <CAAdAUtiXE=CXU_LWG9SpnHsnqUBMC327jC2AvXAFX7-vwwoBog@mail.gmail.com>
From: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Message-ID: <24061be4-e1e1-e59b-d701-ea8723915e36@oracle.com>
Date: Tue, 18 May 2021 11:40:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <CAAdAUtiXE=CXU_LWG9SpnHsnqUBMC327jC2AvXAFX7-vwwoBog@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [2606:b400:8301:1010::16aa]
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To SN6PR10MB3021.namprd10.prod.outlook.com
 (2603:10b6:805:cc::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2606:b400:8301:1010::16aa) by
 SA0PR11CA0003.namprd11.prod.outlook.com (2603:10b6:806:d3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 18:40:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a4aaddd-23d3-4af7-e85d-08d91a2c6fd4
X-MS-TrafficTypeDiagnostic: SA2PR10MB4506:
X-Microsoft-Antispam-PRVS: <SA2PR10MB450610A26135FD1AD081EBD3812C9@SA2PR10MB4506.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3rlBRdl2i0duCkM65Dfhs0WLSawRd5PkuS2NIV6cHrhbWjLs9L5P7wAMvgfzMBTjErqD6cXNaL04+zNoyvU1i9B+vWoGPDzbWUEhkPY4mLRSvA9y94mAVhg5Cb0sAMNGk9xjklKgANvBi2JXt4Fr/XTS74tAhe8tiY4DljcJUEJ1s5SrNjS7UmSdFPXg06e+FIU1Im33Hoew/nOR8zUG33lqFCLwnQ2e0AmvuG+dCbEa5AtGn/Z1MQunogywNyaopWZ7yyBm4862GGwysXF1jo5Pu3aYzSGghNnHyxtgbxAxwP5+YwmLNX1KhbwBAIGC8RTvOKwCIs7dym8sLAa/EyuULpIgHrmsAlCR2gFSSpdu+kCi0TPX15DUI1VTdI7pwX/Z4L4kRfKCz81LpnImIY+bRttdlyw6IhSgXCFNU5kJ7ygB+OsuuPZThvJG6QfJuvgIyJ1cw9K6M3hz0noswEY2mwOdiwQ2UeVSQEYgoElvBDi4GrId8M5hJJiI6kQcNPzKR9tkiAzaVSwKK/loFDoggwXCiEtVVCzlnt1qyFh9PXcaUqariuNkOaOsAy6lZa1j17yeYapyTtN53LRO9uIW8MRMxxTK6txzkF8KmAXGS/BhdOwfj4sAgCuMFAVUEMH9j5ClWbDyM+mQqhsoaNqVldgl5aHVA94IvIIfeHB3xGC4rmV8FjckkB35aog
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB3021.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(376002)(136003)(366004)(39860400002)(8936002)(110136005)(54906003)(2616005)(6486002)(478600001)(5660300002)(7406005)(66476007)(8676002)(36756003)(2906002)(16526019)(186003)(66556008)(7416002)(31696002)(53546011)(6506007)(83380400001)(66946007)(38100700002)(6512007)(44832011)(31686004)(316002)(4326008)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TkFJV0V1WUVZOExWeUhzUVNaV3FRM2RTL3VTVC9JK1c3T3B0MlcyQzcxMTBs?=
 =?utf-8?B?ZElCQmMvRlJ2UWlYdjcvbmJBOXlITnZpSk1aSzJ5eVh0LzNDWUhPblk4dEFP?=
 =?utf-8?B?TnhFWWdtbngxZzhweTdXdktYNUtlYXVhSjdkbzg5U3RBL0VyL2NMSUl2RGgy?=
 =?utf-8?B?OWxGeWNXQVRPQW9iL3kzZXBRelZTd1ZneTdlSlhtWElNZytRWVNGMGtDZG9r?=
 =?utf-8?B?eDM2YXhBK2FaS1dQWmV1THM0bm9DT3Rhdk1pRm03SWJSSFdOQk5BMUxuYmlu?=
 =?utf-8?B?SzJlQTNaaHRHdnFSNTB4KzdER3NuYXIvbDBHaENDMC83bGhUc3IxZnlwMUo0?=
 =?utf-8?B?ajhBUEJITW1iZHg0VHhUbkxiNWQ1VmtYeEZRREpDQlhKQzE5b0NyRTdiSlBW?=
 =?utf-8?B?RW56Q1ZUOEVHRVpqR1paOGRPU2xNZ2VQVGJTOUhNQnpuZHRYa2RqMnFGVGxu?=
 =?utf-8?B?WlRMNVloS1B5UTBJejhocE9Fa2JYK24yVlphZDdzeVA4aVAzZmRvOHkzQVhy?=
 =?utf-8?B?NXpDeW9Ea1B3a2c4UWh2akRjOFhIZ1R5QW9Hb0NzaGxybkdnRklHYlNBanNn?=
 =?utf-8?B?d2dSemszRlpkTUgzNVg3T0NQYjJ4VXViTUE4UnZXSzl5eS9YdFBjRkpjVE1B?=
 =?utf-8?B?dmpDdG92dURzK1VNUkEvQzI5NDBqM3hrcEQzeW1UWEZhdFh6Z3RQMzFHcHpK?=
 =?utf-8?B?SlJ2R0F5cnZ3ZHpPeWUwS3RxTFJ5bjFmOXlpTVhoT3NkVnVsVFVIcmlYa2RU?=
 =?utf-8?B?WGZ0NEFMUzhJUFU1a0tBejh2Z3czalFOQi9yTFZVWlhQSjJyTjI3SXdMZjU3?=
 =?utf-8?B?di9HS0V5NHNiaEdCRUY3WFdsNk5mdVN0QS9QZ1FlREZnK1B2djkwUlM0SmFJ?=
 =?utf-8?B?K3VJS21XalpEd0lpYkVXRXNEbTF2Y1NVZk1CUmp1NmxSbG0rOGc0NlNpdkFo?=
 =?utf-8?B?SGh2N3l1YXVjc0hyNFNKNUpiNWpOTElBRndZQVRINnR3MlFrOWJkM0gzM2JT?=
 =?utf-8?B?K1cxcjIxYnN5S1EwWTBDb2w3QUk5Skl3WEp3SUpSeVMrMkpQRndQT3BhbDJY?=
 =?utf-8?B?U3NYYm8wcWo0TzJyVjJnYWpWT2RvSksyMXl6c2NlRDhuejd0dVZCeVJja0U2?=
 =?utf-8?B?NFA5eGJPcHBZU1Nqbk5WSHRhM1lhVkw1ZjkwditGZ0RBc25JbG9wbVI2QjNU?=
 =?utf-8?B?MXNQSjc0dmFJRndIUlVUQTkvRWZkVExmK0FOVndVaTJ1N1VWcUp6RTNLVUlS?=
 =?utf-8?B?a21PUUh0UEZDMHpTd1E0WU10Tml6TWdHL21HSkRPdkhxTmM4K0lCSjVmTGFz?=
 =?utf-8?B?ektzcndhK3JLOThmQm1SL0ZNSnFBSW9aNE5TQ1ZtK3RnNG5vbmdxRGdybkZ2?=
 =?utf-8?B?VUxjOGlIdGRiZmJrRmQramtEaUs0VVpFYjdMNVhMT0FqOHo4dGRnUTZaWmtT?=
 =?utf-8?B?QnpnTGY4T2F2K1JEYTRiWnhDdGJOVFkvdHh6eStMQ2ZVMEZ1aldrU0g4aFFy?=
 =?utf-8?B?QUlBMEtKQU1lQy9lUTQ4M0ZKL0UrTlphb0xQUXBGKytoUjFTYXluZ3l6Rkp4?=
 =?utf-8?B?c3QyZDBaamNJZVFEVXZuakVlcjZlSE11V1BJc2ZIUXg4K1ZwdVVlR0lHU0xs?=
 =?utf-8?B?ekFNYTVvQlpSRVZhV25yNnNRVnBtM2pOWFNWMnY3QkFSNzBuVFlybDh4QTN5?=
 =?utf-8?B?cFFMem9NYUxPTlFLaGtXL3lESTNzYlRtNEpDYi9LNmM4S0ZtUjI0bFdkQjdW?=
 =?utf-8?B?WjdzNndoclNZZDd6NHhBOHRnWlQyYjg0cW52LzZJdTB1Uzc4aEV3MjZoRzZV?=
 =?utf-8?B?WHBkTkxnd0F5TlQwY1dmZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4aaddd-23d3-4af7-e85d-08d91a2c6fd4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3021.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 18:40:40.9091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xF/VKiRa/JlgeDWB1Sp+OXhAunh96a0I4OSBfurX56XeMlDq3RSE0X/az5z7syR51jMORtcGcm8DWQ3ADqNV1hzgji4FePbIZHHAgY8Aha8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4506
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9988
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=863
 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180128
X-Proofpoint-GUID: 1AE5SwgK8sxow7LsYYGR5xHcjy5GPGqy
X-Proofpoint-ORIG-GUID: 1AE5SwgK8sxow7LsYYGR5xHcjy5GPGqy
X-Mailman-Approved-At: Tue, 18 May 2021 14:43:16 -0400
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>,
 Linuxkselftest <linux-kselftest@vger.kernel.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>,
 KVMARM <kvmarm@lists.cs.columbia.edu>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 LinuxS390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
 Oliver Upton <oupton@google.com>, Marc Zyngier <maz@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 David Rientjes <rientjes@google.com>, KVMPPC <kvm-ppc@vger.kernel.org>,
 Jim Mattson <jmattson@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Sean Christopherson <seanjc@google.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Shier <pshier@google.com>, LinuxMIPS <linux-mips@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu


On 5/18/21 10:25 AM, Jing Zhang wrote:
> Hi David,
>
> On Tue, May 18, 2021 at 11:27 AM David Matlack <dmatlack@google.com> wrote:
>> On Mon, May 17, 2021 at 5:10 PM Jing Zhang <jingzhangos@google.com> wrote:
>> <snip>
>>> Actually the definition of kvm_{vcpu,vm}_stat are arch specific. There is
>>> no real structure for arch agnostic stats. Most of the stats in common
>>> structures are arch agnostic, but not all of them.
>>> There are some benefits to put all common stats in a separate structure.
>>> e.g. if we want to add a stat in kvm_main.c, we only need to add this stat
>>> in the common structure, don't have to update all kvm_{vcpu,vm}_stat
>>> definition for all architectures.
>> I meant rename the existing arch-specific struct kvm_{vcpu,vm}_stat to
>> kvm_{vcpu,vm}_stat_arch and rename struct kvm_{vcpu,vm}_stat_common to
>> kvm_{vcpu,vm}_stat.
>>
>> So in  include/linux/kvm_types.h you'd have:
>>
>> struct kvm_vm_stat {
>>    ulong remote_tlb_flush;
>>    struct kvm_vm_stat_arch arch;
>> };
>>
>> struct kvm_vcpu_stat {
>>    u64 halt_successful_poll;
>>    u64 halt_attempted_poll;
>>    u64 halt_poll_invalid;
>>    u64 halt_wakeup;
>>    u64 halt_poll_success_ns;
>>    u64 halt_poll_fail_ns;
>>    struct kvm_vcpu_stat_arch arch;
>> };
>>
>> And in arch/x86/include/asm/kvm_host.h you'd have:
>>
>> struct kvm_vm_stat_arch {
>>    ulong mmu_shadow_zapped;
>>    ...
>> };
>>
>> struct kvm_vcpu_stat_arch {
>>    u64 pf_fixed;
>>    u64 pf_guest;
>>    u64 tlb_flush;
>>    ...
>> };
>>
>> You still have the same benefits of having an arch-neutral place to
>> store stats but the struct layout more closely resembles struct
>> kvm_vcpu and struct kvm.
> You are right. This is a more reasonable way to layout the structures.
> I remember that I didn't choose this way is only because that it needs
> touching every arch specific stats in all architectures (stat.name ->
> stat.arch.name) instead of only touching arch neutral stats.
> Let's see if there is any vote from others about this.


+1

>
> Thanks,
> Jing
_______________________________________________
kvmarm mailing list
kvmarm@lists.cs.columbia.edu
https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
